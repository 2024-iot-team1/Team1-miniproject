#include <SoftwareSerial.h>

SoftwareSerial mySerial(10, 11); // RX, TX

void setup() {
  Serial.begin(9600);  // 시리얼 통신 시작
  mySerial.begin(9600); // 바코드 스캐너와의 시리얼 통신 시작
  Serial.println("Barcode scanner ready");
}

void loop() {
  if (mySerial.available() > 0) {  // 바코드 스캐너의 데이터가 있는지 확인
    // 데이터를 줄바꿈 없이 읽기
    Serial.println("Detected");
    char c = mySerial.read();  // 바코드 스캐너에서 한 글자씩 읽기
    String barcode = "";  // 바코드 문자열 초기화
    while (c != '\n' && mySerial.available() > 0) {  // 줄바꿈 문자가 나올 때까지 읽기
      barcode += c;  // 읽은 글자를 바코드 문자열에 추가
      c = mySerial.read();  // 다음 글자 읽기
    }
    if (barcode.length() > 0) {  // 바코드 문자열이 비어있지 않으면 출력
      Serial.print("Scanned Barcode: ");  // 스캔된 바코드 출력
      Serial.println(barcode);
    }
  }
}
