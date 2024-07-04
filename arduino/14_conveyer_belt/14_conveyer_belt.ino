/*
   스마트 팩토리 컨베이어벨트 최종 예제

   DC모터 : 레일을 움직임
   서보모터 : 제품을 색상에 따라 분류
   적외선 IR센서 : 물품이 적재됨을 감지.
   컬러센서 : 색상을 아두이노에 전달. 해당 값에 따라 서보모터의 각도가 결정
   RGB : 측정된 제품의 색상을 표시

   동작 순서
   1. 컨베이어 벨트 레일 작동
   2. 적외선 센서로부터 레일에 제품이 적재됨을 감지하면 일시 정지
   3. 레일이 컬러 센서까지 움직이기 시작
   4. 컬러센서에서 정지 후 해당 제품의 색상을 분석
   5. 색상 분석에 따른 결론에 따라 R, G, B가 결정되고, 해당되는 곳으로 서보모터가 동작
   6. 레일이 다시 움직이며 서보모터가 가리키는 방향으로 제품 분류
*/

/* 라이브러리 불러오기 */
#include <Servo.h>              // 서보모터 라이브러리 불러오기
#include <Wire.h>               // I2C 통신에 사용되는 라이브러리

/* 상수 선언 : 핀 번호, 속도제어, 서보모터의 각도*/
#define PIN_DC_DIRECTION 13  // DC모터(레일) 방향을 정하는 핀(현재 B모터 사용)
#define PIN_DC_SPEED 11      // DC모터(레일) 속도를 정하는 핀(현재 B모터 사용)
#define PIN_SERVO 9          // 서보모터 연결 핀
#define PIN_IR A0            // 적외선 IR센서 연결 핀

#define POS_RED 90   // 빨간 색 제품을 분류할 서보모터의 각도
#define POS_GREEN 120  // 초록 색 제품을 분류할 서보모터의 각도
#define POS_BLUE 150    // 파란 색 제품을 분류할 서보모터의 각도

/* 변수 선언 : HW객체, 측정값, 기타 변수, ...*/
Servo servo;
int railSpeed = 120;               // 레일 기본 속도, 초기값은 160
int value = 0;

void setup() {
  Serial.begin(9600);
  /* 모터 설정 */
  pinMode(PIN_DC_DIRECTION, OUTPUT);     // dc모터의 방향을 제어하는 핀을 output으로 설정
  digitalWrite(PIN_DC_DIRECTION, HIGH);  // 방향은 전진. 의도한 방향과 반대일 경우 HIGH -> LOW로 변경
  analogWrite(PIN_DC_SPEED, railSpeed);  // 레일 작동 시작
  servo.attach(PIN_SERVO);               // 서보모터를 아두이노와 연결
  servo.write(90);                        // 초기 서보모터가 가리키는 각도는 0도
  delay(500);                            // 서보모터가 완전히 동작을 끝낸 후 detach를 위해 delay를 부여
  servo.detach();                        // 서보모터와 아두이노 분리

  /* 적외선 센서 설정 */
  pinMode(PIN_IR, INPUT);  // 적외선 센서 핀을 INPUT으로 설정
  Serial.println("공정 시작");
}

void loop() {

  analogWrite(PIN_DC_SPEED, 0);                               // 적외선 센서에서 제품을 감지하여 일시 정지
  /* 제품 적재여부 확인 */
  if (digitalRead(PIN_IR) == HIGH) {                          // 적외선 센서는 물건 감지 시 LOW값을 전달. HIGH라는 것은 감지되지 않았음
    Serial.println("UnDetected");
    return;                                                 // loop에 대한 return문장은 그 즉시 loop문을 종료하고, 처음부터 loop을 시작하게 함
  }
  else if (digitalRead(PIN_IR) == LOW){
    Serial.println("Detected");

    //toneDetected();                                             // 감지되었을 때 나오는 소리를 부저에 출력
    delay(2000);                                                // 2초간 정지
    analogWrite(PIN_DC_SPEED, railSpeed - 20);                  // 레일을 컬러센서까지 움직이기 시작

    while (value < 1) {                                                        // do-while 반복문을 사용하면 최초 1회는 반드시 실행됨
      if (Serial.available()) {       // 시리얼 모니터에 값이 입력되었다면
        value = Serial.parseInt();
        Serial.println(value);
        }  
      else{
        analogWrite(PIN_DC_SPEED, 0);                               // 적외선 센서에서 제품을 감지하여 일시 정지
        delay(1000);
      }                                     
    }

    analogWrite(PIN_DC_SPEED, 0);                               // 컬러 센서에서 일시 정지
    toneDetected();                                             // 감지되었을 때 나오는 소리를 부저에 출력
    delay(1500);                                                // 1.5초 간 레일 대기

    if (value == 2) {                                                                 // 빨간 색 제품
      servo.attach(PIN_SERVO);                                                          // 서보모터를 아두이노와 연결
      servo.write(POS_RED);                                                             // 서보모터를 빨간 색 제품 분류방향으로 회전
    }

    else if (value == 4) {    // 초록 색 제품
      servo.attach(PIN_SERVO);  // 서보모터를 아두이노와 연결
      servo.write(POS_GREEN);   // 서보모터를 빨간 색 제품 분류방향으로 회전
    }

    else if (value == 6){                        // 파란 색 제품
      servo.attach(PIN_SERVO);  // 서보모터를 아두이노와 연결
      servo.write(POS_BLUE);    // 서보모터를 빨간 색 제품 분류방향으로 회전
    }
    else{
      return;
    }
    delay(1500);                                                                       // 측정 결과 표기 후 1.5초 간 레일 대기
    servo.detach();                                                                    // 서보모터와 아두이노 연결 해제
    analogWrite(PIN_DC_SPEED, railSpeed-10);                                              // 레일 작동 시작
    delay(1000);   
  }                                                                    // 다음 제품은 1초 뒤부터 인식 가능
}

/* 적외선 센서, 색상감지 센서에서 물체를 감지했을 때 나오는 소리를 출력 */
void toneDetected() {
  tone(4, 523, 50);  // '도'에 해당. 0.05초간 출력
  delay(100);        // 0.1초간 대기(출력시간 0.05초 + 대기시간 0.05초 = 0.1초)
  tone(4, 784, 50);  // '미'에 해당. 0.05초간 출력
  delay(100);        // 0.1초간 대기(출력시간 0.05초 + 대기시간 0.05초 = 0.1초)
}  // void toneDetected()
