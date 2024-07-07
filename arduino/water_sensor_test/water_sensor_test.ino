#define WATER A0
#define RED 8
#define YELLOW 9
#define GREEN 10

void setup() {
  Serial.begin(9600);
  pinMode(RED, OUTPUT);
  pinMode(YELLOW, OUTPUT);
  pinMode(GREEN, OUTPUT);
}

void loop() {
  int data = analogRead(WATER);
  Serial.println(data);
  if(data > 100){
    digitalWrite(RED, HIGH);
    digitalWrite(GREEN, LOW);
  }
  else {
    digitalWrite(RED, LOW);
    digitalWrite(GREEN, HIGH);
  }
  delay(1000);
  // int light = map(data, 0, 1023, 0, 255);
  // analogWrite(RED);
}
