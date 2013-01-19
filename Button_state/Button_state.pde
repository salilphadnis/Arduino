#define LED 12
#define BUTTON 7

int val = 0;
int old_val = 0;
int state = 0;

void setup () 
{
  pinMode(LED, OUTPUT);  
  pinMode(BUTTON, INPUT);
}

void loop() 
{
  
  val = digitalRead (BUTTON);
  if ((val == HIGH) && (old_val == LOW)) {
    state = 1 - state;
    delay(00);
  }
  
  old_val = val;
  
  if (state == 1) 
  {    
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}

