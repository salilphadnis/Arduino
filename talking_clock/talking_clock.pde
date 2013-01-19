#include <FatReader.h>
#include <SdReader.h>
#include <avr/pgmspace.h>
#include "WaveUtil.h"
#include "WaveHC.h"
#include <Wire.h>
#include "RTClib.h"
#include <string.h>
#include <stdlib.h>	// for itoa() call

RTC_DS1307 RTC;
SdReader card;    // This object holds the information for the card
FatVolume vol;    // This holds the information for the partition on the card
FatReader root;   // This holds the information for the filesystem on the card
FatReader f;      // This holds the information for the file we're play

WaveHC wave;      // This is the only wave (audio) object, since we will only play one at a time
char filename[10];

#define DEBOUNCE 100  // button debouncer

int hour;
int temphour;
int minutes;
int day;
int month;
int year;

// this handy function will return the number of bytes currently free in RAM, great for debugging!   
int freeRam(void)
{
  extern int  __bss_end; 
  extern int  *__brkval; 
  int free_memory; 
  if((int)__brkval == 0) {
    free_memory = ((int)&free_memory) - ((int)&__bss_end); 
  }
  else {
    free_memory = ((int)&free_memory) - ((int)__brkval); 
  }
  return free_memory; 
} 

void sdErrorCheck(void)
{
  if (!card.errorCode()) return;
  putstring("\n\rSD I/O error: ");
  Serial.print(card.errorCode(), HEX);
  putstring(", ");
  Serial.println(card.errorData(), HEX);
  while(1);
}

void setup() {
  // set up serial port
  Wire.begin();
  RTC.begin();

      
  Serial.begin(57600);
  putstring_nl("WaveHC with 6 buttons");
  
   putstring("Free RAM: ");       // This can help with debugging, running out of RAM is bad
  Serial.println(freeRam());      // if this is under 150 bytes it may spell trouble!
  
  // Set the output pins for the DAC control. This pins are defined in the library
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
   
  // pin13 LED
  pinMode(13, OUTPUT);
  pinMode(16,OUTPUT);
  pinMode(17,OUTPUT);
 
  // enable pull-up resistors on switch pins (analog inputs)
  digitalWrite(14, HIGH);  //Analog 0
  digitalWrite(15, HIGH);    //Analog 1
  digitalWrite(16, LOW);    //Analog 2
  digitalWrite(17, HIGH);    //Analog 3
  //digitalWrite(18, HIGH);    //Analog 4
  //digitalWrite(19, HIGH);    //Analog 5
 
  //  if (!card.init(true)) { //play with 4 MHz spi if 8MHz isn't working for you
  if (!card.init()) {         //play with 8 MHz spi (default faster!)  
    putstring_nl("Card init. failed!");  // Something went wrong, lets print out why
    sdErrorCheck();
    while(1);                            // then 'halt' - do nothing!
  }
  
  // enable optimize read - some cards may timeout. Disable if you're having problems
  card.partialBlockRead(true);
 
// Now we will look for a FAT partition!
  uint8_t part;
  for (part = 0; part < 5; part++) {     // we have up to 5 slots to look in
    if (vol.init(card, part)) 
      break;                             // we found one, lets bail
  }
  if (part == 5) {                       // if we ended up not finding one  :(
    putstring_nl("No valid FAT partition!");
    sdErrorCheck();      // Something went wrong, lets print out why
    while(1);                            // then 'halt' - do nothing!
  }
  
  // Lets tell the user about what we found
  putstring("Using partition ");
  Serial.print(part, DEC);
  putstring(", type is FAT");
  Serial.println(vol.fatType(),DEC);     // FAT16 or FAT32?
  
  // Try to open the root directory
  if (!root.openRoot(vol)) {
    putstring_nl("Can't open root dir!"); // Something went wrong,
    while(1);                             // then 'halt' - do nothing!
  }
  
  // Whew! We got past the tough parts.
  putstring_nl("Ready!");
}

void loop() {
  //putstring(".");            // uncomment this to see if the loop isnt running
  
  DateTime now = RTC.now();
  
  hour = now.hour();
  //hour = 10;
  Serial.print(hour, DEC);
  Serial.print(':');
  minutes = now.minute();
  //minutes = 10;
  Serial.print(minutes, DEC);
  Serial.println();     
  
  if (check_switches() == 1) {
    temphour = hour;
    if (hour > 12) {
       temphour = temphour - 12;
    }
    
    getfilename(temphour, filename);
    playcomplete(filename);    
                     
    if (minutes > 19) {
      //Play tens digit 
      getfilename(minutes/10*10, filename);
      playcomplete(filename);     
      
      //Play ones digit  
      getfilename(minutes%10, filename);
      playcomplete(filename);             
    } else {
       if (minutes < 10 && minutes > 0) {
         playcomplete("O.WAV");
       }
       if (minutes > 0) {
         getfilename(minutes, filename);
         playcomplete(filename);    
       }
    }
          
    if (hour > 11) {
       playcomplete("PM.WAV");
    } else {
       playcomplete("AM.WAV");
    }
    
  }
  
  //Say the date
  if (digitalRead(15) == LOW) {
    //putstring_nl("In check 2");
    month = now.month();
    day = now.day();
    year = now.year();
    
    //play the day
    if (day > 19) {
      //Play tens digit 
      getfilename(day/10*10, filename);
      playcomplete(filename);     
      
      //Play ones digit  
      getfilename(day%10, filename);
      playcomplete(filename);             
    } else {
        getfilename(day, filename);
        playcomplete(filename);    
    }
    
    //Play the month
    getmonthfile(month, filename);
    playcomplete(filename);
    
    //Play the year
    playcomplete("2000.WAV");      
    getfilename(year % 2000, filename);   
    playcomplete(filename);
    
  }
  delay(200);
}

byte check_switches()
{
  static byte previous[6];
  static long time[6];
  byte reading;
  byte pressed;
  byte index;
  pressed = 0;

  for (byte index = 0; index < 5; ++index) {
    reading = digitalRead(14 + index);
    if (reading == LOW && previous[index] == HIGH && millis() - time[index] > DEBOUNCE)
    {
      // switch pressed
      time[index] = millis();
      pressed = index + 1;
      break;
    }
    previous[index] = reading;
  }
  // return switch number (1 - 6)
  return (pressed);
}


// Plays a full file from beginning to end with no pause.
void playcomplete(char *name) {
  char i;
  uint8_t volume;
  int v2;
  int rnd;
  
  // call our helper to find and play this name
  playfile(name);
  while (wave.isplaying) {
    
  }    
  // now its done playing
  //analogWrite(6, 0);
}

void playfile(char *name) {
  // see if the wave object is currently doing something
  if (wave.isplaying) {// already playing something, so stop it!
    wave.stop(); // stop it    
  }
  
  // look in the root directory and open the file
  if (!f.open(root, name)) {
    putstring("Couldn't open file "); Serial.print(name); return;
  }
  // OK read the file and turn it into a wave object
  if (!wave.create(f)) {
    putstring_nl("Not a valid WAV"); return;
  }
  
  // ok time to play! start playback
  wave.play();
}

void getfilename(int i, char *name) {
  char tempbuf[10];
  
  itoa(i, tempbuf, 10);
  Serial.begin(57600);
  strcpy(name, tempbuf);
  strcat(name, ".WAV");
}

void getmonthfile (int mon, char* name) {
  
  switch (mon) {
    case 1: strcpy(name, "JAN.WAV");
            break;
    case 2: strcpy(name, "FEB.WAV");
            break;
    case 3: strcpy(name, "MAR.WAV");
            break;
    case 4: strcpy(name, "APR.WAV");
            break;
    case 5: strcpy(name, "MAY.WAV");
            break;
    case 6: strcpy(name, "JUN.WAV");
            break;
    case 7: strcpy(name, "JUL.WAV");
            break;
    case 8: strcpy(name, "AUG.WAV");
            break;
    case 9: strcpy(name, "SEP.WAV");
            break;
    case 10: strcpy(name, "OCT.WAV");
            break;
    case 11: strcpy(name, "NOV.WAV");
            break;
    case 12: strcpy(name, "DEC.WAV");
            break;
  }
}
  
  
  

