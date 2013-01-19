
const int ledPins[] = {2, 3, 4, 5, 6, 7};
const int NbrLEDs = sizeof(ledPins) / sizeof(ledPins[0]);
const int analogInPin = 0;
const int decay = 5;

const boolean LED_ON = LOW;
const boolean LED_OFF = HIGH;

int sensorValue = 0;
int storedValue = 0;
int ledLevel = 0;

void setup() {
  for (int led = 0; led < NbrLEDs; led++) 
  {
    pinMode(ledPins[led], OUTPUT);
  }
}

void loop () {
  sensorValue = analogRead(analogInPin);
  storedValue = max(sensorValue, storedValue);
  ledLevel = map(storedValue, 0, 1023, 0, NbrLEDs);
  for (int led = 0; led < NbrLEDs; led++)
  {
    if (led < ledLevel) {
      digitalWrite(ledPins[led], LED_ON);
    }
    else {
      digitalWrite(ledPins[led], LED_OFF);
    }
  }
  storedValue = storedValue - decay;
  delay(10);
}

