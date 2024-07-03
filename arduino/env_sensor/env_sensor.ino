#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#include <SoftwareSerial.h>

#define DHTPIN 2
#define DHTTYPE DHT11

#define BUZZER_PIN 8
#define RED_LED_PIN 9
#define BLUE_LED_PIN 10
#define GREEN_LED_PIN 11
#define RELAY_PIN 12

DHT dht(DHTPIN, DHTTYPE);

float temperature = 0.0;
float humidity = 0.0;

#define TEMP_THRESHOLD 30.0
#define HUMIDITY_THRESHOLD 70.0

unsigned long lastDHTReadTime = 0;
unsigned long lastBuzzerCheckTime = 0;
unsigned long lastLEDCheckTime = 0;
unsigned long lastSignalCheckTime = 0;
unsigned long lastFanCheckTime = 0;

const unsigned long DHT_INTERVAL = 2000; // 2초
const unsigned long BUZZER_INTERVAL = 10; // 10ms
const unsigned long LED_INTERVAL = 100; // 100ms
const unsigned long SIGNAL_INTERVAL = 100; // 100ms
const unsigned long FAN_INTERVAL = 100; // 100ms

bool policeSiren = false;
unsigned long sirenStartTime = 0;
int sirenFrequency = 1000;
bool increasing = true;

SoftwareSerial mySerial(5, 6); // RX, TX

void setup() {
  Serial.begin(9600);
  dht.begin();
  
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(RED_LED_PIN, OUTPUT);
  pinMode(BLUE_LED_PIN, OUTPUT);
  pinMode(GREEN_LED_PIN, OUTPUT);
  pinMode(RELAY_PIN, OUTPUT);

  Serial.begin(9600);  // 기본 시리얼 통신 시작 (디버깅 용도)
  mySerial.begin(9600); // SoftwareSerial 통신 시작
}

void loop() {
  unsigned long currentTime = millis();

  // DHT 센서 읽기
  if (currentTime - lastDHTReadTime >= DHT_INTERVAL) {
    lastDHTReadTime = currentTime;
    readDHT();
  }

  // 부저 제어
  // if (currentTime - lastBuzzerCheckTime >= BUZZER_INTERVAL) {
  //   lastBuzzerCheckTime = currentTime;
  //   controlBuzzer();
  // }

  // LED 제어
  if (currentTime - lastLEDCheckTime >= LED_INTERVAL) {
    lastLEDCheckTime = currentTime;
    controlLED();
  }

  // 아두이노 간 통신 제어
  if (currentTime - lastSignalCheckTime >= SIGNAL_INTERVAL) {
    lastSignalCheckTime = currentTime;
    contorlSerial();
  }

  // 릴레이 모듈을 통한 환기팬 제어
  if (currentTime - lastFanCheckTime >= FAN_INTERVAL) {
    lastFanCheckTime = currentTime;
    contorlRelay();
  }
}

void readDHT() {
  humidity = dht.readHumidity();
  temperature = dht.readTemperature();
  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("Failed to read from DHT sensor!");
  } else {
    Serial.print("Humidity: ");
    Serial.print(humidity);
    Serial.print(" %\t");
    Serial.print("Temperature: ");
    Serial.print(temperature);
    Serial.println(" *C");
  }
}

void controlBuzzer() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    if (!policeSiren) {
      policeSiren = true;
      sirenStartTime = millis();
      sirenFrequency = 1000;
      increasing = true;
    }

    unsigned long elapsedTime = millis() - sirenStartTime;
    if (elapsedTime < 500) {
      if (increasing) {
        sirenFrequency += 10;
        if (sirenFrequency >= 1500) {
          increasing = false;
        }
      } else {
        sirenFrequency -= 10;
        if (sirenFrequency <= 1000) {
          increasing = true;
        }
      }
      tone(BUZZER_PIN, sirenFrequency);
    } else {
      sirenStartTime = millis();
    }

    //Serial.print("Siren Frequency: ");
    //Serial.println(sirenFrequency);
  } else {
    noTone(BUZZER_PIN);
    policeSiren = false;
  }
}

void controlLED() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    digitalWrite(RED_LED_PIN, LOW);
    digitalWrite(BLUE_LED_PIN, HIGH);
    digitalWrite(GREEN_LED_PIN, HIGH);
    delay(100);
    digitalWrite(RED_LED_PIN, HIGH);
    digitalWrite(BLUE_LED_PIN, LOW);
    digitalWrite(GREEN_LED_PIN, HIGH);
  } else {
    digitalWrite(RED_LED_PIN, HIGH);
    digitalWrite(BLUE_LED_PIN, HIGH);
    digitalWrite(GREEN_LED_PIN, LOW);
  }
}

void contorlSerial() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    mySerial.println("Warning");  // SoftwareSerial로 데이터 전송
    Serial.println("Sent: Warning"); // 시리얼 모니터에 전송된 데이터 표시
  }
}

void contorlRelay(){
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    digitalWrite(RELAY_PIN, HIGH);
  }
  else {
    digitalWrite(RELAY_PIN, LOW);
  }
}
