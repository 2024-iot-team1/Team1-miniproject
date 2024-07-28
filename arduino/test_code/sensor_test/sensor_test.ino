#define BOX_IR1 A1
#define BOX_IR2 A2
#define BOX_IR3 A3

void setup() {
  Serial.begin(9600);

  pinMode(BOX_IR1, INPUT);
  pinMode(BOX_IR2, INPUT);
  pinMode(BOX_IR3, INPUT);
}

void loop() {
  checkBoxSensors();
}

void checkBoxSensors() {
  if (digitalRead(BOX_IR1) == LOW) { // 상자 1에 물품이 들어갔을 때
    Serial.println("Item detected in Box 1");
  } 

  if (digitalRead(BOX_IR2) == LOW) { // 상자 2에 물품이 들어갔을 때
    Serial.println("Item detected in Box 2");
  } 

  if (digitalRead(BOX_IR3) == LOW) { // 상자 3에 물품이 들어갔을 때
    Serial.println("Item detected in Box 3");
  }
}