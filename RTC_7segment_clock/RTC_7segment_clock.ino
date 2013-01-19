 #include <Wire.h>
#include "Adafruit_LEDBackpack.h"
#include "Adafruit_GFX.h"
#include "RTClib.h"

RTC_DS1307 RTC;
Adafruit_7segment disp = Adafruit_7segment();

const int buttonPin = 9;     // the number of the pushbutton pin
const int displayTime = 5;   // number of seconds to display the clock
int buttonState = 0;         // variable for reading the pushbutton status

void setup() 
{
  Wire.begin();
  RTC.begin();
  if (! RTC.isrunning()) 
  {
    //RTC.adjust(DateTime(__DATE__, __TIME__));
  }
  disp.begin(0x70);
}

void loop() 
{
  //If button pressed, display time for about 5 seconds
  buttonState = digitalRead(buttonPin);
  disp.clear();
    
  if (buttonState == LOW) {         
    for (int index = 0; index < displayTime; index++)  {
      disp.print(getDecimalTime());
      disp.drawColon(true);
      disp.writeDisplay();
      delay(500);
      disp.drawColon(false);
      disp.writeDisplay();
      delay(500);
    }
  }
  
  disp.clear();
  disp.writeDisplay();
  delay(500);
  
}

int getDecimalTime()
{
  DateTime now = RTC.now();
  int decimalTime = now.hour() * 100 + now.minute();
  return decimalTime;
}


