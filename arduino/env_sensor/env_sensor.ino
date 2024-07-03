#include <Thread.h>
#include <ThreadController.h>
#include <DHT.h>

#define DHTPIN 2
#define DHTTYPE DHT11

#define BUZZER_PIN 8
#define RED_LED_PIN 9
#define BLUE_LED_PIN 10

DHT dht(DHTPIN, DHTTYPE);

ThreadController controller = ThreadController();

Thread threadDHT = Thread();
Thread threadBuzzer = Thread();
Thread threadLED = Thread();

float temperature = 0.0;
float humidity = 0.0;

#define TEMP_THRESHOLD 30.0
#define HUMIDITY_THRESHOLD 70.0

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
    digitalWrite(BUZZER_PIN, HIGH);
  } else {
    digitalWrite(BUZZER_PIN, LOW);
  }
}

void controlLED() {
  if (temperature > TEMP_THRESHOLD || humidity > HUMIDITY_THRESHOLD) {
    digitalWrite(RED_LED_PIN, HIGH);
    digitalWrite(BLUE_LED_PIN, LOW);
  } else {
    digitalWrite(RED_LED_PIN, LOW);
    digitalWrite(BLUE_LED_PIN, HIGH);
  }
}

void setup() {
  Serial.begin(9600);
  dht.begin();
  
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(RED_LED_PIN, OUTPUT);
  pinMode(BLUE_LED_PIN, OUTPUT);

  // DHT 스레드 설정
  threadDHT.onRun(readDHT);
  threadDHT.setInterval(2000);
  controller.add(&threadDHT);

  // 부저 스레드 설정
  threadBuzzer.onRun(controlBuzzer);
  threadBuzzer.setInterval(100);
  controller.add(&threadBuzzer);

  // LED 스레드 설정
  threadLED.onRun(controlLED);
  threadLED.setInterval(100);
  controller.add(&threadLED);
}

void loop() {
  controller.run();
}
