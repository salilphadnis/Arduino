#include <LiquidCrystal.h>

LiquidCrystal lcd(7, 8, 9, 10, 11, 12);

int RedPin = 3;
int GreenPin = 6;
int BluePin = 5;

int RedPot = 0;
int GreenPot = 1;
int BluePot = 2;

int val = 0;

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  
  pinMode(RedPin, OUTPUT);
  pinMode(GreenPin, OUTPUT);
  pinMode(BluePin, OUTPUT);  
}

void loop() {
 
  //lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Red Green Blue");
  
  val = analogRead(RedPot);
  val = map(val, 0, 1023, 0, 255);
  Serial.print("RedPot: ");
  Serial.println(val);  
  lcd.setCursor(0,1);
  lcd.print("   ");  //Clear the previous value
  lcd.setCursor(0,1);  
  lcd.print(val);
  val = 255 - val;  
  analogWrite(RedPin, val);
  
  val = analogRead(GreenPot);
  val = map(val, 0, 1023, 0, 255);
  Serial.print("GreenPot: ");
  Serial.println(val);
  lcd.setCursor(4, 1);
  lcd.print("   ");  //Clear the previous value
  lcd.setCursor(4, 1);
  lcd.print(val);  
  val = 255 - val;  
  analogWrite(GreenPin, val);
  
  val = analogRead(BluePot);
  val = map(val, 0, 1023, 0, 255);
  Serial.print("BluePot: ");
  Serial.println(val);
  lcd.setCursor(10, 1);
  lcd.print("   ");  //Clear the previous value
  lcd.setCursor(10,1);  
  lcd.print(val);  
  val = 255 - val;  
  analogWrite(BluePin, val);
  
  delay(100);

}  
