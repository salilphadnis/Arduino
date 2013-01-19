#define CAR_RED 12
#define CAR_YELLOW 11
#define CAR_GREEN 10
#define PED_RED 9
#define PED_GREEN 8
#define BUTTON 2
#define CROSS_TIME 5000
unsigned long changeTime;

void setup() {
  pinMode(CAR_RED, OUTPUT);
  pinMode(CAR_YELLOW, OUTPUT);
  pinMode(CAR_GREEN, OUTPUT);
  pinMode(PED_RED, OUTPUT);
  pinMode(PED_GREEN, OUTPUT);
  
  digitalWrite(CAR_GREEN, HIGH);
  digitalWrite(PED_RED, HIGH);
}

void loop() {
  int state = digitalRead(BUTTON);
  if ( (state == HIGH) &&  (millis() - changeTime) > 5000) {
    changeLights();
  }
}

void changeLights() {
  digitalWrite(CAR_GREEN, LOW);
  digitalWrite(CAR_YELLOW, HIGH);
  delay(2000);
  
  digitalWrite(CAR_YELLOW, LOW);
  digitalWrite(CAR_RED, HIGH);
  delay(1000);
  
  digitalWrite(PED_RED, LOW);
  digitalWrite(PED_GREEN, HIGH);
  delay(CROSS_TIME);

  //flash the PED GREEN
  for(int x=0; x<10; x++) {
    digitalWrite(PED_GREEN, HIGH);
    delay(250);
    digitalWrite(PED_GREEN, LOW);
    delay(250);
  }
  
  digitalWrite(PED_GREEN, LOW);
  delay(500);
  
  digitalWrite(CAR_RED, LOW);
  digitalWrite(CAR_GREEN, HIGH);
  
  changeTime = millis();
}
  
  
  
  
  

