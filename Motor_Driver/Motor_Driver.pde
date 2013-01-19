#define switchPin 2
#define motorPin1 3
#define motorPin2 4
#define speedPin 9
#define potPin 0

int Mspeed = 0;

void setup() {
  pinMode(switchPin, INPUT);
  pinMode(motorPin1, OUTPUT);
  pinMode(motorPin2, OUTPUT);
  pinMode(speedPin, OUTPUT);
  //Serial.begin(9600);
  
}

void loop() {
  Mspeed = analogRead(potPin)/4;
  analogWrite(speedPin, Mspeed);
  //Serial.println(Mspeed);
  
  if (digitalRead(switchPin)) {
    digitalWrite(motorPin1, LOW);
    digitalWrite(motorPin2, HIGH);
  } 
  else {
    digitalWrite(motorPin1, HIGH);
    digitalWrite(motorPin2, LOW);
  }  
}

