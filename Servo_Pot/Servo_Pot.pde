#include <Servo.h>

Servo servo1;

void setup() {
  servo1.attach(5);
  Serial.begin(9600);
}

void loop(){
  int angle = analogRead(2);
  angle = map(angle, 0, 1023, 0, 180);
  Serial.println(angle);
  servo1.write(angle);
  delay(15);
}



