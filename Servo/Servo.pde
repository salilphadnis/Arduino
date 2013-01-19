#include <Servo.h>

Servo servoMotor;

int analogPin = 0;
int servoPin = 2;

int analogValue = 0;

void setup() {
  servoMotor.attach(servoPin);
}

void loop() {
  analogValue = analogRead(analogPin);
  analogValue = map(analogValue, 0, 1023, 0, 179);
  
  servoMotor.write(analogValue);
  delay(15);
}

