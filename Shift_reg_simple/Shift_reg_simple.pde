int RCLK_Pin = 9;  //pin 12 on the 75HC595
int SRCLK_Pin = 10; //pin 10 on the 75HC595

void setup(){
  pinMode(RCLK_Pin, OUTPUT);
  pinMode(SRCLK_Pin, OUTPUT);

}               

void loop() {
  
    digitalWrite(SRCLK_Pin, LOW);
    digitalWrite(RCLK_Pin, LOW);
    delay(100);
    digitalWrite(SRCLK_Pin, HIGH);
    digitalWrite(RCLK_Pin, HIGH);
    delay(100);
}

