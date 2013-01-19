#define POTPIN 2
#define PWMPIN 9

int val = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  val = analogRead(POTPIN);
  Serial.println(val/4);
  analogWrite(9, val/4);
  delay(10);
}

