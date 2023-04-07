String readString;
#include <Wire.h> 
#include  <TimerOne.h>
#include "DHT.h"
#include <PZEM004Tv30.h>
#include <SoftwareSerial.h>

#if !defined(PZEM_RX_PIN) && !defined(PZEM_TX_PIN)
#define PZEM_RX_PIN 12
#define PZEM_TX_PIN 8
#endif

SoftwareSerial pzemSWSerial(PZEM_RX_PIN, PZEM_TX_PIN);
PZEM004Tv30 pzem(pzemSWSerial);

float sensor;
float sensor_raw;
float voltage;
float current;
float power;

float h;

String myString;
String received_data;
char c;
String data_buffer;
int Index1,Index2,Index3,Index4,Index5,Index6, Index7, Index8, Index9;
String secondValue, thirdValue, fourthValue, fifthValue, sixthValue, seventhValue, eighthValue, firstValue;

unsigned long refresh_time;
unsigned long refresh_time_prev;


unsigned long i=0;               
volatile boolean zero_cross=0;  
int AC_pin = 10;                
int alpha = 125;                                          
int freqStep = 75;    
int zc_condition = 0;
int zc_condition_prev = 0;
int saturation = 128;
int alpha_buff = 125;

#define DHTPIN 4
#define DHTTYPE DHT22 

DHT dht(DHTPIN, DHTTYPE);

void setup() {
  pinMode(AC_pin, OUTPUT);                          

  attachInterrupt(0, zero_cross_detect, RISING);    
  Timer1.initialize(freqStep);                      
  Timer1.attachInterrupt(zc_check, freqStep);  
  
  Serial.begin(9600);
  dht.begin();


}


void zero_cross_detect() {    
  zero_cross = true;               
  i=0;
  digitalWrite(AC_pin, LOW);       
}   

void zc_check() {                   
  if(zero_cross == true && alpha_buff > 3) {              
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

  if (i > 200){
        zc_condition = 0;            
      } else{
        zc_condition = 1;
      }
 /*
 if (zc_condition == 1){
   voltage = 220;
 } else {
   voltage = 0;
 }
 */
                         
}    

void loop() {

    while (Serial.available()>0){
    delay(10);
    c = Serial.read();
    myString += c;
    data_buffer = myString;
   
  }


  //memisah misahkan data (parsing) serial yang diterima
  if (myString.length()>0){
    Index1 = myString.indexOf('*');
    Index2 = myString.indexOf('|', Index1+1);
    Index3 = myString.indexOf('|', Index2+1);
    Index4 = myString.indexOf('|', Index3+1);
    Index5 = myString.indexOf('|', Index4+1);

    firstValue = myString.substring(Index1+1, Index2);
    secondValue = myString.substring(Index2+1, Index3);
    thirdValue = myString.substring(Index3+1, Index4);
    fourthValue = myString.substring(Index4+1, Index5);
    myString="";
  }
  
  if(firstValue == ""){
    alpha_buff = 0;
  } else{
    alpha_buff = firstValue.toInt();
  }
  
  //PID PEMANAS
  alpha = map(alpha_buff, 0,100,80,10);
  
  
  //baca sensor suhu
  sensor_raw = ((0.1155*analogRead(A1))-16.755);
  sensor = (0.5* sensor) + (0.5 * sensor_raw);
  
  //baca sensor kelembaban
  
  refresh_time = millis() - refresh_time_prev;


  if (refresh_time > 30000){
  
  h = dht.readHumidity();


  refresh_time_prev = millis();
  
  //baca sensor daya
  voltage = pzem.voltage();
  if (isnan(voltage)){
    voltage = 0;
  }
  current = pzem.current();
  power = pzem.power();


  }

  Serial.print(sensor);  
  Serial.print(":");
  Serial.print(h); 
  Serial.print(":");
  Serial.print(voltage);
  Serial.print(":");
  Serial.print(current);
  

  
  Serial.println(); 
  delay(500);
 

    
}
