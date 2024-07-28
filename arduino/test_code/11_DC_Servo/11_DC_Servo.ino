#include <Servo.h>                                         // 서보모터 라이브러리 불러오기
#include <SoftwareSerial.h>

#define PIN_DC_DIRECTION 13                                // DC모터(레일) 방향을 정하는 핀 (L298P 쉴드의 MOTOR B포트 핀 사용)
#define PIN_DC_SPEED 11                                    // DC모터(레일) 속도를 정하는 핀 (L298P 쉴드의 MOTOR B포트 핀 사용)

SoftwareSerial mySerial(5, 6); // RX, TX

const int railSpeed = 120;                                 // 레일(DC모터) 속도 선언. 레일 속도 조정 필요 시 이 값을 변경
const int railMoveMillis = 2000;                           // 레일이 움직일 시간 선언(밀리초). 조정 필요 시 이 값을 변경
int recvData;
Servo servo;

void setup() {
    pinMode(PIN_DC_DIRECTION, OUTPUT);                     // dc모터의 방향을 제어하는 핀을 output으로 설정
    digitalWrite(PIN_DC_DIRECTION, HIGH);                  // 방향은 전진. 의도한 방향과 반대일 경우 HIGH -> LOW로 변경
    Serial.begin(9600);  // 기본 시리얼 통신 시작 (디버깅 용도)
    mySerial.begin(9600); // SoftwareSerial 통신 시작
}
void loop() {
  if (mySerial.available() > 0) {  // SoftwareSerial 데이터가 있는지 확인
    String data = mySerial.readStringUntil('\n');  // 데이터를 읽고 문자열로 변환
    Serial.print("Received: ");  // 시리얼 모니터에 데이터 출력
    Serial.println(data);
    recvData = data.toInt();
  }
  if (recvData == 0)
  {
    analogWrite(PIN_DC_SPEED, 0);
  }
  else{
    moveRail();
  }
  delay(1000);
}
void moveRail(){
    analogWrite(PIN_DC_SPEED, railSpeed);                   // 레일이 움직이기 시작
    delay(railMoveMillis);                                  // railMoveMillis(=2000ms = 2s)간 움직임
    // analogWrite(PIN_DC_SPEED, 0);                           // 정지
    // delay(1000);
}
