void setup() {
  pinMode(11, OUTPUT);
}

void loop() {
  tone(11, 262);
  delay(1000);
  noTone(11); // 능동부저에 LOW(0V) 출력
  delay(1000);
}
