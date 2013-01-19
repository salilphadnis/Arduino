#include <Servo.h>

Servo servoLeft;
Servo servoRight;

void setup()
{
  servoLeft.attach(13);
  servoRight.attach(12);
  
  forward(2000);
  turnLeft(600);
  turnRight(600);
  backward(2000);
  
  disableServos();
}

void loop()
{
}

void forward(int time)
{
  servoLeft.writeMicroseconds(1700);
  servoRight.writeMicroseconds(1300);
  delay(time);
}

void turnLeft(int time)                      // Left turn function
{
  servoLeft.writeMicroseconds(1300);         // Left wheel clockwise
  servoRight.writeMicroseconds(1300);        // Right wheel clockwise
  delay(time);                               // Maneuver for time ms
}

void turnRight(int time)                     // Right turn function
{
  servoLeft.writeMicroseconds(1700);         // Left wheel counterclockwise
  servoRight.writeMicroseconds(1700);        // Right wheel counterclockwise
  delay(time);                               // Maneuver for time ms
}

void backward(int time)                      // Backward function
{
  servoLeft.writeMicroseconds(1300);         // Left wheel clockwise
  servoRight.writeMicroseconds(1700);        // Right wheel counterclockwise
  delay(time);                               // Maneuver for time ms
}

void disableServos()                         // Halt servo signals
{                                            
  servoLeft.detach();                        // Stop sending servo signals
  servoRight.detach();
}

