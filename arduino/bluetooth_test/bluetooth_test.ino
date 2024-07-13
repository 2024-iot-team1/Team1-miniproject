#include <SoftwareSerial.h>
 
#define BT_RXD 4  // 4
#define BT_TXD 3 // 3


SoftwareSerial BTSerial(BT_RXD, BT_TXD);

void setup()
{
  Serial.begin(9600);
  BTSerial.begin(9600);
  // pinMode(LED_PIN, OUTPUT);
  // pinMode(RELAY_PIN, OUTPUT);

  Serial.println("Bluetooth 시작");
  BTSerial.println("안녕하세요 블루투스");
}


void loop() {
  if(Serial.available())              // 시리얼 통신으로 문자가 들어오면
  {
    BTSerial.write(Serial.read());      // 블루투스시리얼 통신으로 발송
  }
  if(BTSerial.available())               // 블루투스 시리얼 통신으로 문자가 들어오면
  {
    Serial.write(BTSerial.read());       // 시리얼 창에 표시(시리얼 통신으로 출력)
  }
}