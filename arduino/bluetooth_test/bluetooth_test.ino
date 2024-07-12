#include <SoftwareSerial.h>
 
#define BT_RXD 2  // 4
#define BT_TXD 3 // 3
// #define LED_PIN 8
// #define RELAY_PIN 9

SoftwareSerial bluetooth(BT_RXD, BT_TXD);

void setup()
{
  Serial.begin(9600);
  bluetooth.begin(9600);
  // pinMode(LED_PIN, OUTPUT);
  // pinMode(RELAY_PIN, OUTPUT);

  Serial.println("Bluetooth 시작");
  bluetooth.println("안녕하세요 블루투스");
}


void loop() {
  // 블루투스에서 수신한 데이터를 시리얼 모니터에 출력
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

  // 시리얼 모니터에서 입력한 데이터를 블루투스 모듈로 전송
  if (Serial.available()) {
    bluetooth.write(Serial.read());
  }
}