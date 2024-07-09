/* 라이브러리 불러오기 */
#include <Servo.h>              // 서보모터 라이브러리 불러오기
#include <Wire.h>               // I2C 통신에 사용되는 라이브러리
#include <SoftwareSerial.h>

/* 상수 선언 : 핀 번호, 속도제어, 서보모터의 각도*/
#define PIN_DC_DIRECTION 13  // DC모터(레일) 방향을 정하는 핀
#define PIN_DC_SPEED 11      // DC모터(레일) 속도를 정하는 핀
#define PIN_SERVO 9          // 서보모터 연결 핀
#define PIN_IR A0            // 적외선 IR센서 연결 핀
#define PIN_BUZZER 4         // 부저 핀

// 상자에 부착된 적외선 센서 핀
#define BOX_IR1 A1
#define BOX_IR2 A2
#define BOX_IR3 A3

// 바코드(QR) 스캐너에 부착된 적외선 센서 핀
#define SCAN_PIN A4

#define POS_RED 120   // 빨간 색 제품을 분류할 서보모터의 각도
#define POS_GREEN 165 // 초록 색 제품을 분류할 서보모터의 각도
#define POS_BLUE 210  // 파란 색 제품을 분류할 서보모터의 각도

#define BT_RXD 3
#define BT_TXD 2

/* 변수 선언 : HW객체, 측정값, 기타 변수, ...*/
Servo servo;
int railSpeed = 200;  // 레일 기본 속도
int scan_stop_check = 0;
int scan_check = 0;
int box_check;
int state = 1;


SoftwareSerial mySerial(5, 6); // RX, TX
SoftwareSerial bluetooth(BT_RXD, BT_TXD); // 3, 2 -> 아두이노에는 반대로 연결

void setup() {
  Serial.begin(9600);
  mySerial.begin(9600); // SoftwareSerial 통신 시작
  bluetooth.begin(9600);

  /* 모터 설정 */
  pinMode(PIN_DC_DIRECTION, OUTPUT);     // DC모터의 방향을 제어하는 핀을 OUTPUT으로 설정
  digitalWrite(PIN_DC_DIRECTION, LOW);  // 방향은 전진. 의도한 방향과 반대일 경우 HIGH -> LOW로 변경
  servo.attach(PIN_SERVO);               // 서보모터를 아두이노와 연결
  servo.write(120);                      // 초기 서보모터가 가리키는 각도는 0도
  delay(500);                            // 서보모터가 완전히 동작을 끝낸 후 detach를 위해 delay를 부여
  servo.detach();                        // 서보모터와 아두이노 분리

  /* 적외선 센서 설정 */
  pinMode(PIN_IR, INPUT);  // 적외선 센서 핀을 INPUT으로 설정
  pinMode(PIN_BUZZER, OUTPUT); // 부저 핀을 OUTPUT으로 설정
  
  // 상자 적외선 센서
  pinMode(BOX_IR1, INPUT);
  pinMode(BOX_IR2, INPUT);
  pinMode(BOX_IR3, INPUT);

  // 바코드 스케너에 쓰일 적외선 센서
  pinMode(SCAN_PIN, INPUT);

  Serial.println("공정 시작");
}

void loop() {
  /* 시리얼 통신 데이터 수신 확인 */
  state = checkSerial();
  if (state <= 0) {
    analogWrite(PIN_DC_SPEED, 0);
  }
  else if (state > 0){
    /* 제품 적재여부 확인 */
    if (digitalRead(PIN_IR) == HIGH) {  // 적외선 센서는 물건 감지 시 LOW값을 전달. HIGH라는 것은 감지되지 않았음
      analogWrite(PIN_DC_SPEED, railSpeed);  // 레일 작동 계속
    } 
    else if (digitalRead(PIN_IR) == LOW) 
    {
      Serial.println("Detected");
      toneDetected();  // 감지되었을 때 나오는 소리를 부저에 출력
      analogWrite(PIN_DC_SPEED, 0);  // 적외선 센서에서 제품을 감지하여 일시 정지
      delay(2000);  // 2초간 정지
      analogWrite(PIN_DC_SPEED, railSpeed);  // 레일을 컬러센서까지 움직이기 시작


      // 바코드 or QR코드 스캐너 영역에서 정지
      while (scan_stop_check == 0){
        if (digitalRead(SCAN_PIN) == LOW){
          analogWrite(PIN_DC_SPEED, 0);  // 적외선 센서에서 제품을 감지하여 일시 정지
          toneDetected();  // 감지되었을 때 나오는 소리를 부저에 출력
          Serial.println("Stop for scan");
          delay(1500);  // 1.5초 간 레일 대기
          scan_stop_check = 1;
        }
      } 
      scan_stop_check = 0;

      Serial.println("Scan Start!!");
      // 바코드 or QR 코드 스캔
      scan_check = 0;
      while(scan_check  == 0){
        scan_check = recvScanData();
      }
      Serial.println("Scan Complete!");

      analogWrite(PIN_DC_SPEED, railSpeed);  // 레일 작동 시작

    // 상자에 물품이 들어갔는지 확인
      while (box_check == 0) {
        box_check = checkBoxSensors();
        if (box_check == 1) toneDetected();
      }  
      box_check = 0;
      delay(1000);
    }
  }
}

/* 시리얼 통신 및 블루투스 데이터 수신 확인 및 처리 */
int checkSerial() {
  int receivedData;
  if (mySerial.available() > 0) {  // 데이터가 있는지 확인
    String data = mySerial.readStringUntil('\n');  // 데이터를 문자열로 읽기
    int receivedData = data.toInt();  // 문자열을 정수로 변환
    if (receivedData <= 0){
        tone(PIN_BUZZER, 1000, 1000);  // 부저를 울림
        Serial.println("Emergency Stop!");
        return 0;
    }
    else return 1;
  }

  else if (bluetooth.available() > 0){
    char c = bluetooth.read();
    if (c == '0'){
      Serial.print("received data : ");
      Serial.write(c);
      return 0;
    }
    else if (c=='1'){
      Serial.print("received data : ");
      Serial.write(c);
      return 1;
    }
  }
}

int recvScanData() {
  if (bluetooth.available() > 0) {
    char command = bluetooth.read();
    if (command == '2') {
      servo.attach(PIN_SERVO);
      Serial.print("received data : ");
      Serial.write(command);
      servo.write(POS_RED);
      delay(1500);
      servo.detach();
      return 1;
    }
    else if (command == '4'){
      servo.attach(PIN_SERVO);
      Serial.print("received data : ");
      Serial.write(command);
      servo.write(POS_BLUE);
      delay(1500);
      servo.detach();
      return 1;
    }
    else if (command == '6'){
      servo.attach(PIN_SERVO);
      Serial.print("received data : ");
      Serial.write(command);
      servo.write(POS_GREEN);
      delay(1500);
      servo.detach();
      return 1;
    }
    else{
      servo.write(120);
      return 0;
    }
  }
  else {
    return 0;
  }
}

/* 적외선 센서, 색상감지 센서에서 물체를 감지했을 때 나오는 소리를 출력 */
void toneDetected() {
  tone(PIN_BUZZER, 523, 50);  // '도'에 해당. 0.05초간 출력
  delay(100);  // 0.1초간 대기(출력시간 0.05초 + 대기시간 0.05초 = 0.1초)
  tone(PIN_BUZZER, 784, 50);  // '미'에 해당. 0.05초간 출력
  delay(100);  // 0.1초간 대기(출력시간 0.05초 + 대기시간 0.05초 = 0.1초)
}

// 상자에 물품이 들어갔는지 확인하는 함수
int checkBoxSensors() {
  if (digitalRead(BOX_IR1) == LOW) {  // 상자 1에 물품이 들어갔을 때
    Serial.println("Item detected in Box 1");
    return 1;
  } 

  if (digitalRead(BOX_IR2) == LOW) {  // 상자 2에 물품이 들어갔을 때
    Serial.println("Item detected in Box 2");
    return 1;
  } 

  if (digitalRead(BOX_IR3) == LOW) {  // 상자 3에 물품이 들어갔을 때
    Serial.println("Item detected in Box 3");
    return 1;
  }
  return 0;
}
