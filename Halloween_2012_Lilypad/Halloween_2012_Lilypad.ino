/*
 Fade
 
 This example shows how to fade an LED on pin 9
 using the analogWrite() function.
 
 This example code is in the public domain.
 
 */
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by
int fadeDelay = 50;
int SerialDelay = 300;

void setup()  { 
  // declare pin 9 to be an output:
  pinMode(11, OUTPUT);    
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(3, OUTPUT);

} 

void loop()  { 
  // set the brightness of pin 9:
  
  //On
  digitalWrite(11, HIGH);
  delay(SerialDelay);
  digitalWrite(10, HIGH);
  delay(SerialDelay);
  digitalWrite(9, HIGH);
  delay(SerialDelay);
  digitalWrite(6, HIGH);
  delay(SerialDelay);
  digitalWrite(3, HIGH);
  delay(SerialDelay);
  
  //Off
  digitalWrite(3, LOW);
  delay(SerialDelay);
  digitalWrite(6, LOW);
  delay(SerialDelay);
  digitalWrite(9, LOW);
  delay(SerialDelay);
  digitalWrite(10, LOW);
  delay(SerialDelay);
  digitalWrite(11, LOW);
  delay(SerialDelay);
  
  delay(2000);
  
  
  for (int i=0; i<2; i++) {
  //
    brightness = 5;
    while (brightness < 250) {
     analogWrite(3, brightness);    
     analogWrite(6, brightness);    
     analogWrite(9, brightness);    
     analogWrite(10, brightness);    
     analogWrite(11, brightness);
     delay(fadeDelay);
     brightness = brightness + fadeAmount;  
    }     
  
   while (brightness > 0) {
     analogWrite(3, brightness);    
     analogWrite(6, brightness);    
     analogWrite(9, brightness);    
     analogWrite(10, brightness);    
     analogWrite(11, brightness);
     delay(fadeDelay);
     brightness = brightness - fadeAmount;  
    }   
  
    analogWrite(3, 0);    
    analogWrite(6, 0);    
    analogWrite(9, 0);    
    analogWrite(10, 0);    
    analogWrite(11, 0);
    
    delay(200);
   }     
  delay(1000); 
                       
}
