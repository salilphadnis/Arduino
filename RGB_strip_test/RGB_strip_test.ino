// color swirl! connect an RGB LED to the PWM pins as indicated
// in the #defines
// public domain, enjoy!
 
#define REDPIN 5
#define GREENPIN 6
#define BLUEPIN 3
 
#define FADESPEED 15     // make this higher to slow down
#define DELAY 200
#define SHORTDELAY 100
#define BRIGHTNESS 50

void setup() {
  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);
}
 
 
void loop() {
  int r, g, b;

analogWrite(REDPIN, BRIGHTNESS);
delay(SHORTDELAY);
analogWrite(REDPIN,0);
delay(SHORTDELAY);
analogWrite(REDPIN,BRIGHTNESS);
//delay(SHORTDELAY);

//Fade to 0
for (r=BRIGHTNESS; r > -1; r--) {
  analogWrite(REDPIN, r);
  delay(20);
}

//analogWrite(REDPIN,0);
delay(DELAY);

analogWrite(GREENPIN, BRIGHTNESS);
delay(SHORTDELAY);
analogWrite(GREENPIN,0);
delay(SHORTDELAY);
analogWrite(GREENPIN,BRIGHTNESS);
//delay(SHORTDELAY);

//Fade to 0
for (r=BRIGHTNESS; r > -1; r--) {
  analogWrite(GREENPIN, r);
  delay(20);
}

//analogWrite(REDPIN,0);
delay(DELAY);

analogWrite(BLUEPIN, BRIGHTNESS);
delay(SHORTDELAY);
analogWrite(BLUEPIN,0);
delay(SHORTDELAY);
analogWrite(BLUEPIN,BRIGHTNESS);
//delay(SHORTDELAY);

//Fade to 0
for (r=BRIGHTNESS; r > -1; r--) {
  analogWrite(BLUEPIN, r);
  delay(20);
}

//analogWrite(REDPIN,0);
delay(DELAY);

/*
analogWrite(REDPIN, 0);
analogWrite(GREENPIN, BRIGHTNESS);
delay(DELAY);
analogWrite(GREENPIN, 0);
analogWrite(BLUEPIN, BRIGHTNESS);
delay(DELAY);
analogWrite(BLUEPIN, 0);
*/

/* 
  // fade from blue to violet
  for (r = 0; r < 256; r++) { 
    analogWrite(REDPIN, r);
    delay(FADESPEED);
  } 
  // fade from violet to red
  for (b = 255; b > 0; b--) { 
    analogWrite(BLUEPIN, b);
    delay(FADESPEED);
  } 
  // fade from red to yellow
  for (g = 0; g < 256; g++) { 
    analogWrite(GREENPIN, g);
    delay(FADESPEED);
  } 
  // fade from yellow to green
  for (r = 255; r > 0; r--) { 
    analogWrite(REDPIN, r);
    delay(FADESPEED);
  } 
  // fade from green to teal
  for (b = 0; b < 256; b++) { 
    analogWrite(BLUEPIN, b);
    delay(FADESPEED);
  } 
  // fade from teal to blue
  for (g = 255; g > 0; g--) { 
    analogWrite(GREENPIN, g);
    delay(FADESPEED);
  } 
  */
  
}
