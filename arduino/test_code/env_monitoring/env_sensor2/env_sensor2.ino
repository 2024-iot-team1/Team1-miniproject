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
#define BT_RXD 4
#define BT_TXD 3

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
const unsigned long SIGNAL_INTERVAL = 2000; // 2초
const unsigned long FAN_INTERVAL = 100; // 100ms

bool policeSiren = false;
unsigned long sirenStartTime = 0;
int sirenFrequency = 1000;
bool increasing = true;

bool ledState = false; // LED 상태를 저장하기 위한 변수
unsigned long lastLEDChangeTime = 0; // 마지막 LED 변경 시간을 저장하는 변수
const unsigned long LED_CHANGE_INTERVAL = 200; // LED 변경 간격 (200ms)

// 블루투스 통신을 위한 시리얼
SoftwareSerial bluetooth(BT_RXD, BT_TXD); // 4, 3

void setup() {
  Serial.begin(9600);
  dht.begin();

  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(RED_LED_PIN, OUTPUT);
  pinMode(BLUE_LED_PIN, OUTPUT);
  pinMode(GREEN_LED_PIN, OUTPUT);
  pinMode(RELAY_PIN, OUTPUT);

  mySerial.begin(9600); // SoftwareSerial 통신 시작
  bluetooth.begin(9600);
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
    controlSerial();
  }

  // 릴레이 모듈을 통한 환기팬 제어
  if (currentTime - lastFanCheckTime >= FAN_INTERVAL) {
    lastFanCheckTime = currentTime;
    controlRelay();
  }
  if (bluetooth.available()) {
    char c = bluetooth.read();
    Serial.write(c);
    // WPF로부터 특정 명령을 수신했을 때 처리
    if (c == '1') {
      Serial.println("LED 켜기 명령 수신");
      // digitalWrite(LED_PIN, LOW); // 실제 LED 핀 제어 코드
    } else if (c == '0') {
      Serial.println("LED 끄기 명령 수신");
      // digitalWrite(LED_PIN, HIGH); // 실제 LED 핀 제어 코드
    } else if (c == '3') {
      Serial.println("FAN ON!!");
      // digitalWrite(RELAY_PIN, HIGH);
    } else if (c == '4') {
      Serial.println("FAN OFF!");
      // digitalWrite(RELAY_PIN, LOW);
    }
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

    char tempString[10];
    char humString[10];
    dtostrf(temperature, 6, 2, tempString); // 온도 변환
    dtostrf(humidity, 6, 2, humString);  // 습도 변환

    String data = String(tempString) + "," + String(humString);

    bluetooth.println(data);
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
  } else {
    noTone(BUZZER_PIN);
    policeSiren = false;
  }
}

void controlLED() {
  unsigned long currentTime = millis();
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    if (currentTime - lastLEDChangeTime >= LED_CHANGE_INTERVAL) {
      lastLEDChangeTime = currentTime;
      ledState = !ledState; // LED 상태 변경
      if (ledState) {
        digitalWrite(RED_LED_PIN, HIGH);
        digitalWrite(BLUE_LED_PIN, LOW);
        digitalWrite(GREEN_LED_PIN, HIGH);
      } else {
        digitalWrite(RED_LED_PIN, LOW);
        digitalWrite(BLUE_LED_PIN, HIGH);
        digitalWrite(GREEN_LED_PIN, HIGH);
      }
    }
  } else {
    digitalWrite(RED_LED_PIN, HIGH);
    digitalWrite(BLUE_LED_PIN, HIGH);
    digitalWrite(GREEN_LED_PIN, LOW);
  }
}

void controlSerial() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    mySerial.println(0);  // SoftwareSerial로 데이터 전송
    Serial.println("Sent: 0"); // 시리얼 모니터에 전송된 데이터 표시
  }
  else {
    mySerial.println(1);
    Serial.println("Sent : 1");
  }
}

void controlRelay() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    digitalWrite(RELAY_PIN, HIGH);
  } else {
    digitalWrite(RELAY_PIN, LOW);
  }
}
