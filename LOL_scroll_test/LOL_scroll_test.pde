/*
  Requires LoL Shield library, at least V0.2Beta 

http://code.google.com/p/lolshield/downloads/list

  And the Font.cpp from LoL_Shield-100915.zip on ikkei's page:

http://web.mac.com/kxm_ikkei/Site/LoL.html

  Based on original TEXT SAMPLE CODE for LOL Shield for Arduino
  Copyright 2009/2010 Benjamin Sonntag <benjamin@sonntag.fr> http://benjamin.sonntag.fr/

  (This version edited by Walfas)
*/

#include "Charliplexing.h"
#include "Font.h"
#include "WProgram.h"

// Technically the number of columns of LEDs minus one
#define SCREEN_WIDTH 13

// Scroll delay: lower values result in faster scrolling
#define SCROLL_DELAY 80 

/* How long to wait after the last letter before
    going back to the beginning and repeating */
#define REPEAT_DELAY 500

int textLength, totalPixels;
//char text[]="Aw yeah, this thing is pretty awesome!";
char text[] = "Happy Halloween !!";

void setup() {
  LedSign::Init();
  getLength(text, &textLength, &totalPixels);
}

void loop() {
  int x=0;
  for(int j=SCREEN_WIDTH; j>-totalPixels-SCREEN_WIDTH; j--) {
    x=j;
    LedSign::Clear();
    for(int i=0; i<textLength; i++) {
      x += Font::Draw(text[i],x,0);
      if (x>=SCREEN_WIDTH)
        break;
    }
    delay(SCROLL_DELAY);
  }
  delay(REPEAT_DELAY);
}

void getLength(char* charArray, int* lengthPtr, int* pixelPtr) {
  /* Finds the length of a string in terms of characters
     and pixels and assigns them to the variable at
     addresses lengthPtr and pixelPtr, respectively. */

  int charCount = 0, pixelCount = 0;
  char * charPtr = charArray;

  // Count chars until newline or null character reached
  while (*charPtr != '\0' && *charPtr != '\n') {
    charPtr++;
    charCount++;

    /* Increment pixelCount by the number of pixels
       the current character takes up horizontally. */
    pixelCount += Font::Draw(*charPtr,-SCREEN_WIDTH,0);
  }

  *pixelPtr = pixelCount;
  *lengthPtr = charCount;
}
