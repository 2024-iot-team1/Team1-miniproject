#include <SoftwareSerial.h>

SoftwareSerial mySerial(5, 6); // RX, TX

void setup() {
  Serial.begin(9600);  // 기본 시리얼 통신 시작 (디버깅 용도)
  mySerial.begin(9600); // SoftwareSerial 통신 시작
}

void loop() {
  if (mySerial.available() > 0) {  // SoftwareSerial 데이터가 있는지 확인
    String data = mySerial.readStringUntil('\n');  // 데이터를 읽고 문자열로 변환
    Serial.print("Received: ");  // 시리얼 모니터에 데이터 출력
    Serial.println(data);
  }
  delay(1000);  // 1초 대기
}