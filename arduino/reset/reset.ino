#include <Servo.h>              // 서보모터 라이브러리 불러오기

#define PIN_SERVO 9          // 서보모터 연결 핀

Servo servo;

void setup() {
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);
  servo.attach(PIN_SERVO);
  servo.write(100);
}

void loop() {
  // put your main code here, to run repeatedly:

}
