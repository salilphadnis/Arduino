int ledPin = 11;
float sinVal;
int ledVal;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  for(int x=0; x<180; x++) {
    sinVal = (sin(x*(3.1412/180)) );
    ledVal = int(sinVal*255);
    Serial.println(ledVal);
    analogWrite(ledPin, ledVal);
    delay(0.01);
  }
}

