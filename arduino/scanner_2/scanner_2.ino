#include <usbhid.h>
#include <usbhub.h>
#include <hiduniversal.h>
#include <hidboot.h>
#include <SPI.h>
#include <SoftwareSerial.h>

#define BT_RXD 4  // 4
#define BT_TXD 3  // 3

SoftwareSerial bluetooth(BT_RXD, BT_TXD);

class MyParser : public HIDReportParser {
  public:
    MyParser();
    void Parse(USBHID *hid, bool is_rpt_id, uint8_t len, uint8_t *buf);
  protected:
    uint8_t KeyToAscii(bool upper, uint8_t mod, uint8_t key);
    virtual void OnKeyScanned(bool upper, uint8_t mod, uint8_t key);
    virtual void OnScanFinished();
  private:
    String barcode;  // 바코드 데이터를 저장할 버퍼
};

MyParser::MyParser() : barcode("") {}

void MyParser::Parse(USBHID *hid, bool is_rpt_id, uint8_t len, uint8_t *buf) {
  // If error or empty, return
  if (buf[2] == 1 || buf[2] == 0) return;

  for (uint8_t i = 7; i >= 2; i--) {
    // If empty, skip
    if (buf[i] == 0) continue;

    // If enter signal emitted, scan finished
    if (buf[i] == UHS_HID_BOOT_KEY_ENTER) {
      OnScanFinished();
    } else {
      // If not, continue normally
      // If bit position not in 2, it's uppercase words
      OnKeyScanned(i > 2, buf[0], buf[i]);
    }
    return;
  }
}

uint8_t MyParser::KeyToAscii(bool upper, uint8_t mod, uint8_t key) {
  // Letters
  if (VALUE_WITHIN(key, 0x04, 0x1d)) {
    if (upper) return (key - 4 + 'A');
    else return (key - 4 + 'a');
  }
  // Numbers
  else if (VALUE_WITHIN(key, 0x1e, 0x27)) {
    return ((key == UHS_HID_BOOT_KEY_ZERO) ? '0' : key - 0x1e + '1');
  }
  return 0;
}

void MyParser::OnKeyScanned(bool upper, uint8_t mod, uint8_t key) {
  uint8_t ascii = KeyToAscii(upper, mod, key);
  if (ascii) {
    barcode += (char)ascii;  // 버퍼에 추가
    Serial.print((char)ascii);
  }
}

void MyParser::OnScanFinished() {
  Serial.println(" - Finished");
  bluetooth.println(barcode);  // 바코드 데이터를 블루투스 시리얼 포트로 전송
  barcode = "";  // 버퍼 초기화
}

USB          Usb;
USBHub       Hub(&Usb);
HIDUniversal Hid(&Usb);
MyParser     Parser;

void setup() {
  Serial.begin(9600);
  Serial.println("Start");
  bluetooth.begin(9600);

  if (Usb.Init() == -1) {
    Serial.println("OSC did not start.");
  }

  delay(200);

  Hid.SetReportParser(0, &Parser);

  Serial.println("Bluetooth 시작");
  bluetooth.println("안녕하세요 블루투스");
}

void loop() {
  Usb.Task();
}
