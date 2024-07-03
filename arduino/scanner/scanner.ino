#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX

void setup() {
  Serial.begin(9600);  // 시리얼 통신 시작
  mySerial.begin(9600); // 바코드 스캐너와의 시리얼 통신 시작
  Serial.println("Barcode scanner ready");
}

void loop() {
  if (mySerial.available() > 0) {  // 바코드 스캐너의 데이터가 있는지 확인
    String barcode = mySerial.readStringUntil('\n');  // 데이터를 문자열로 읽기
    Serial.print("Scanned Barcode: ");  // 스캔된 바코드 출력
    Serial.println(barcode);
  }
}

