int SER_Pin = 9;   //pin 14 on the 75HC595
int RCLK_Pin = 10;  //pin 12 on the 75HC595
int SRCLK_Pin = 11; //pin 11 on the 75HC595

//How many of the shift registers - change this
#define number_of_74hc595s 1 

//do not touch
#define numOfRegisterPins number_of_74hc595s * 8

boolean registers[numOfRegisterPins];

const prog_uint8_t BitMap[8][8] = {   // store in program memory to save RAM
        {1,1,1,1,1,1,1,1},
        {1,1,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0},
        {1,1,1,1,1,1,1,1},
        {1,1,0,0,0,0,1,1},
        {1,1,0,0,0,0,0,0},
        {1,1,1,1,1,1,1,1},
        {1,1,0,0,0,0,1,1},            
    };
    
void setup(){
  pinMode(SER_Pin, OUTPUT);
  pinMode(RCLK_Pin, OUTPUT);
  pinMode(SRCLK_Pin, OUTPUT);

  //reset all register pins
  clearRegisters();
  writeRegisters();
}               

//set all register pins to LOW
void clearRegisters(){
  for(int i = numOfRegisterPins - 1; i >=  0; i--){
     registers[i] = LOW;
  }
} 

//Set and display registers
//Only call AFTER all values are set how you would like (slow otherwise)
void writeRegisters(){

  digitalWrite(RCLK_Pin, LOW);
  //delay(200);

  for(int i = numOfRegisterPins - 1; i >=  0; i--){
    digitalWrite(SRCLK_Pin, LOW);
    delay(250);

    int val = registers[i];

    digitalWrite(SER_Pin, val);
    digitalWrite(SRCLK_Pin, HIGH);
    delay(250);
  }
  digitalWrite(RCLK_Pin, HIGH);

}

//set an individual pin HIGH or LOW
void setRegisterPin(int index, int value){
  registers[index] = value;
}

void DisplayBitMap()
{

} 
    
void loop(){

  for (byte y=0; y<8; y++) {
    
    for (byte x=0; x<8; x++) {
      if (BitMap[y][x] == 1) {
        setRegisterPin(x, HIGH); 
      } else {
         setRegisterPin(x, LOW);
      }
    }
    
    writeRegisters();  //MUST BE CALLED TO DISPLAY CHANGES
    delay(500);
  }
  
  //setRegisterPin(7, HIGH);
  //setRegisterPin(3, HIGH);
  //setRegisterPin(4, LOW);
  //setRegisterPin(5, HIGH);
  //setRegisterPin(7, HIGH);


  //Only call once after the values are set how you need.
}
