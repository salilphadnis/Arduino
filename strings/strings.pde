#include <string.h>
#include <stdlib.h>	// for itoa() call

char filename[10];
int tempint;

void setup() {
  
  tempint = 1;
  int2name(tempint, filename);
  Serial.println(filename);
}

void loop() {
}

void int2name(int i, char *name) {
  char tempbuf[10];
  
  itoa(i, tempbuf, 10);
  Serial.begin(57600);
  strcpy(name, tempbuf);
  strcat(name, ".WAV");
}


