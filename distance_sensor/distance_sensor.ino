
void setup() {
  // initialize serial communication:
  Serial.begin(9600);
}

const int pingPin = 1;

void loop () {
  long distance;
  
  distance = analogRead(pingPin);
  
  delay(100);

   distance /= 2;  
   Serial.print("distance = ");
   Serial.print(distance);
   Serial.println(" in");
   
   
}



