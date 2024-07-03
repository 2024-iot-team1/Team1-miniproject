#include <SoftwareSerial.h>

SoftwareSerial mySerial(5, 6); // RX, TX

void setup() {
  Serial.begin(9600);  // 기본 시리얼 통신 시작 (디버깅 용도)
  mySerial.begin(9600); // SoftwareSerial 통신 시작
}

void loop() {
  mySerial.println("Hello from Arduino 1");  // SoftwareSerial로 데이터 전송
  Serial.println("Sent: Hello from Arduino 1"); // 시리얼 모니터에 전송된 데이터 표시
  delay(1000);  // 1초 대기
}
