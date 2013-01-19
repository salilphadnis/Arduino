const int ledPins[] = {2, 3, 4, 5, 6, 7};
const int NbrLEDs = sizeof(ledPins) / sizeof(ledPins[0]);
const int wait = 30;

const boolean LED_ON = LOW;
const boolean LED_OFF = HIGH;

void setup() {
  for (int led = 0; led < NbrLEDs; led++) 
  {
    pinMode(ledPins[led], OUTPUT);
  }
}

void loop() {
  for (int led = 0; led < NbrLEDs-1; led++) 
  {
    digitalWrite(ledPins[led], LED_ON);
    delay(wait);
    digitalWrite(ledPins[led + 1], LED_ON);
    delay(wait);
    digitalWrite(ledPins[led], LED_OFF);
    delay(wait);
  }
  for (int led = NbrLEDs; led > 0; led--) {
    digitalWrite(ledPins[led], LED_ON);
    delay(wait);
    digitalWrite(ledPins[led - 1], LED_ON);
    delay(wait);
    digitalWrite(ledPins[led], LED_OFF);
    delay(wait*2);
  }
}

    
