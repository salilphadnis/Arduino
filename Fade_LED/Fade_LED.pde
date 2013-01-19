#define LED 9

int i = 0;

void setup() {
  pinMode(LED, OUTPUT);
}

void loop() {
  
   for (i=1; i<255; i++) {
      analogWrite(LED, i);
      delay(10);
   }
   
   for (i=255; i>1; i--) {
     analogWrite(LED, i);
     delay(10);
   }
   
}


