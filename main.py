######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
import time
from datetime import datetime
import sys
import serial
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import *
from PyQt5 import QtGui, QtCore, Qt,QtQml
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
import sys
from PyQt5.QtQml import QQmlApplicationEngine
from RadialBar import RadialBar
import threading
#----------------------------------------------------------------#

import csv
import PyCVQML
print (datetime.now())

#current_time = dt.datetime.now()

baudrate = 9600
serial_status = 'disconnected'
serial_status_prev = 'disconnected'
print ("select your arduino port:")

def serial_ports():
    if sys.platform.startswith('win'):
        ports = ['COM%s' % (i + 1) for i in range(256)]
    elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
        # this excludes your current terminal "/dev/tty"
        ports = glob.glob('/dev/tty[A-Za-z]*')
    elif sys.platform.startswith('darwin'):
        ports = glob.glob('/dev/tty.*')
    else:
        raise EnvironmentError('Unsupported platform')

    result = []
    for port in ports:
        try:
            s = serial.Serial(port)
            s.close()
            result.append(port)
        except (OSError, serial.SerialException):
            pass
    return result
print(str(serial_ports()))

port = ""#input("write port : ")
ser = ""#serial.Serial(port, 9600, timeout=3)


save_time = 0
save_time_prev = 0


waktu = ""
dt = 0
dt_prev = time.time()


i=0

alpha = 0.0
sensor = 23
sensor_prev = 23
sensor_filtered = 23
error = 0.0
error_prev = 0.0
setpoint = 0.0
kp_control = 0
ki_control = 0
kd_control = 0
p_control = 0.0
i_control = 0.0
d_control = 0.0
pid_control = 0.0
saturation = 100
i_windup = 100
offset = 0
motor = "OFF"
motor_speed = 0


humidity = 0

waktu = datetime.now()
print(waktu.day)
title = str("PID DATA " ) + str(waktu.day)+str("-")+str(waktu.month)+str("-")+str(waktu.year) + str(".csv")
fields = ['time','sp', 'sensor','sensor filtered','e', 'p', 'i', 'd','control signal']
filename = title
filename_buffer = str("buffer.csv")

time_n = 0
time_n_prev = 0

analysis = ''
motor_response_equation = ''
step_value = 0
mode = "PID"

power_gui = 0

step_level = 0
motor_command = 0
filter_weight = 0.9

sampling_rate = 0

ser_bytes = '0'
serial_send_time = 0
serial_send_time_prev = 0

serial_read = 0

serial_data = ""
data = []
data_send = ""

voltage = 0
current = 0
power = 0

########## mengisi class table dengan instruksi pyqt5#############
#----------------------------------------------------------------#
class table(QObject):    
    def __init__(self, parent = None):
        super().__init__(parent)
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine(self)
        self.engine.rootContext().setContextProperty("backend", self)    
        self.engine.load(QUrl("main.qml"))
        sys.exit(self.app.exec_())
    
    @pyqtSlot(result=int)
    def get_tiempo(self):
        date_time = QDateTime.currentDateTime()
        unixTIME = date_time.toSecsSinceEpoch()
        #unixTIMEx = date_time.currentMSecsSinceEpoch()
        return unixTIME
    
    
    @pyqtSlot(result=float)
    def sensor_val_read(self):  return sensor
    
    @pyqtSlot(result=float)
    def power_val_read(self):  return round(motor_command,1)
    
    @pyqtSlot(result=list)
    def port_val_read(self):  return (serial_ports())
    
    @pyqtSlot(result=float)
    def humidity(self):  return (round(humidity,1))
    
    @pyqtSlot(result=float)
    def voltage(self):  return (round(voltage,1))
    
    
    @pyqtSlot(result=float)
    def current(self):  return (round(current * 1000,1))
    
    @pyqtSlot(result=float)
    def power(self):  return (round(power,1))
    
    
    ########setpoint value from GUI##################
    @pyqtSlot('QString')
    def setpoint(self, value):
        global setpoint
        setpoint = float(value)
        #print(setpoint)
        
        
    @pyqtSlot('QString')
    def filter_weight(self, value):
        global filter_weight
        filter_weight = float(value)
       
    
    
    @pyqtSlot('QString')
    def setP_control(self, value):
        global kp_control
        kp_control = float(value)
        #ser.write(alpha.encode())
    
    @pyqtSlot('QString')
    def setI_control(self, value):
        global ki_control
        ki_control = float(value)

        
    @pyqtSlot('QString')
    def setD_control(self, value):
        global kd_control
        kd_control = float(value)

    @pyqtSlot('QString')
    def analysis(self, value):
        global analysis
        analysis = str(value)
        print(analysis)
        
    @pyqtSlot('QString')
    def step_level(self, value):
        global step_level
        step_level = str(value)
        print(step_level)
        
        
    @pyqtSlot('QString')
    def mode(self, value):
        global mode
        mode = str(value)
        print(mode)
        
    @pyqtSlot('QString')
    def motor(self, value):
        global motor
        motor = value
        print(motor)
        
    @pyqtSlot('QString')
    def connection(self, status):
        global serial_status
        serial_status = status
        print(status)
        #print(port)
        
        
    @pyqtSlot('QString')
    def port_number(self, port_number):
        global port
        port = str(port_number)  
        print(port)
    
    
        
        
def pid_control_process(num):
    global i
    global dt
    global error
    global error_prev
    global sensor
    global sensor_filtered
    global dt_prev
    global p_control
    global kp_control
    global i_control
    global ki_control
    global i_windup
    global d_control
    global kd_control
    global pid_control
    global time_n
    global time_n_prev
    global motor_speed
    global analysis
    global motor_command
    global serial_send_time
    global serial_send_time_prev
    global sensor_prev
    global serial_read
    global ser
    global serial_status_prev
    
    global save_time_prev
    global save_time
    
    global humidity
    global voltage
    global current
    global power
    
    global data_send
    
    
    while True:
        #print(ki_control)
        dt = round(time.time() - dt_prev ,3)
    
        #######sensor filter###################
        sensor_filtered = (float(1-filter_weight) * float(sensor)) + (float(filter_weight) * float(sensor_filtered))
        
        #######calculate error#################
        error = setpoint - sensor_filtered
        
        #######proportional control#############
        p_control = kp_control * error
        
        ########integral control###############
        i_control = round((((ki_control*error * dt) + i_control)),2)
        
        ########integral windup###############
        if (i_control > i_windup):
            i_control = i_windup
        
        
        #########derivative control##############
        if (dt < 0.000001):
            dt = 0.000001
        d_control = round((kd_control * ((error - error_prev)/dt)),2)

        ######### p + i + d control###############
        pid_control = p_control + i_control + d_control
        
        
        ###########saturation######################
        if (pid_control > saturation):
            pid_control = saturation
            i_windup = i_control
        elif(pid_control < 0):
            pid_control = 0 
        else:
            pid_control = pid_control
            i_windup = saturation
        
        
        ##########send pid value to microcontroller###########
        if (motor == "ON"):
            pid_control = pid_control        
            
            save_time = time.time() - save_time_prev
            waktu = datetime.now()
            if (save_time > 30):
                with open(filename, 'a') as csvfile:
                    csvwriter = csv.writer(csvfile)
                    rows = [ [str(str(waktu.hour) + str(":") + str(waktu.minute)+ str(":") + str(waktu.second))
                              ,str(setpoint),str(sensor),str(sensor_filtered),str(error) , str(p_control), str(i_control),str(d_control), str(motor_command)]]
                    csvwriter.writerows(rows)
                
                with open(filename_buffer, 'a') as csvfile:
                    csvwriter = csv.writer(csvfile)
                    time_n = time.time() - time_n_prev
                    rows = [ [str(str(waktu.hour) + str(":") + str(waktu.minute)+ str(":") + str(waktu.second))
                              ,str(setpoint),str(sensor),str(sensor_filtered),str(error) , str(p_control), str(i_control),str(d_control), str(motor_command)]]
                    csvwriter.writerows(rows)
                    
                save_time_prev = time.time()
        if (motor == "OFF"):
            pid_control = 0
            i_control = 0
            time_n_prev = time.time()
            
            
        if (mode == "PID"):        
            motor_speed = pid_control + offset
            motor_command = pid_control
        
        if (mode == "STEP"):
            motor_speed = int(step_level) + offset
            motor_command = int(step_level)
        
        
        if (serial_status == 'connected'):
            if (serial_status != serial_status_prev):
                ser = serial.Serial(str(port),9600,timeout=0.1)
            
            try:
                serial_data = ser.readline().decode('utf-8')[:-2]
                data = serial_data.split(":")
                
            except:
                pass
            print(serial_data)
            try:
                sensor = float(data[0])
                humidity = float(data[1])
                voltage = float(data[2])
                current = float(data[3])
                power = voltage*current
            except:
                pass
            
            #print(serial_data, humidity)
            serial_send_time = time.time() - serial_send_time_prev
            
            if (serial_send_time > 0.5):
                #print(data_send)
                data_send = str("*") + str(int(motor_speed)) + str("|") + str("2") + str("|") + str("3") + str("|")+ str("4") +str("|")
                    
                ser.write(str(data_send).encode())
                serial_read = 1
                serial_send_time_prev = time.time()
            else:
                serial_read = 0
                
        else :
            if (serial_status != serial_status_prev):
                ser.close()
        
        
        
        dt_prev = time.time()
        
        error_prev = error
        sensor_prev = sensor
        
        serial_status_prev = serial_status
        time.sleep(0.1)
#----------------------------------------------------------------#

########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    
    t1 = threading.Thread(target=pid_control_process, args=(10,))
    t1.start()
    
    
    QtQml.qmlRegisterType(RadialBar, "SDK", 1,0, "RadialBar")
    PyCVQML.registerTypes()
    main = table()
    
    
#----------------------------------------------------------------#