String readString;


#include <Wire.h> 

#include  <TimerOne.h>          
float sensor;
float sensor_raw;

volatile int i=0;               
volatile boolean zero_cross=0;  
int AC_pin = 11;                
int alpha = 125;                                          
int freqStep = 75;    
int zc_condition;
int saturation = 128;
int alpha_buff = 125;

void setup() {
  

   pinMode(AC_pin, OUTPUT);                          

  attachInterrupt(0, zero_cross_detect, RISING);    
  Timer1.initialize(freqStep);                      
  Timer1.attachInterrupt(zc_check, freqStep);  
  
  Serial.begin(9600);


}


void zero_cross_detect() {    
  zero_cross = true;               
  i=0;
  digitalWrite(AC_pin, LOW);       
}   

void zc_check() {                   
  if(zero_cross == true && alpha > 5) {              
    if(i>=alpha) {                     
      digitalWrite(AC_pin, HIGH);        
      i=0;                       
      zero_cross = false; 
    } 
    else {
      i++;     
    }                                
  }
  else {
    digitalWrite(AC_pin, LOW); //debug                                  
    i++;
  }

   if (i > saturation){
        zc_condition = 0;            
      } else{
        zc_condition = 1;
      }
                            
}    

void loop() {

  while (Serial.available()) {
    char c = Serial.read();  
    readString += c; 
    delay(2);  
  }

    if (readString.length() >0) {
    
    alpha_buff  = readString.toInt();  
    
 readString=""; 
  }
  //10 untuk nyala maksimal dan 125 untuk mati maksimal
  alpha = map(alpha_buff, 0,100,125,30);
  
  
  sensor_raw = ((0.1155*analogRead(A1))-16.755);
  sensor = (0.5* sensor) + (0.5 * sensor_raw);
  
  Serial.println(sensor);  

}
