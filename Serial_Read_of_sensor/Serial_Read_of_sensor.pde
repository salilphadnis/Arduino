#define LED 9
#define SENSOR 0

int val = 0;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

void loop() {
  val = analogRead(SENSOR);
  Serial.println(val/4);
  analogWrite(LED, val/4);
  delay(100);
}
