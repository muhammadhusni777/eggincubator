import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import SDK 1.0
import QtCharts 2.1
import "controls"

import PyCVQML 1.0

import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Window {
	id: root
	visible: true
	width: 1400
	height: 880
	title:"EGG HATCHING RESEARCH"
	color:"#024959"
	property bool fullscreen: false
	
	
	Image{
		  width :100
		  height : 100
          x:50
          y:20         
          source:"upi.png"
		  
	}
	
	
	Image{
		  width :80
		  height : 100
          x:750
          y:20         
          source:"egg.png"
		  
	}
	
	Text {
					
					//anchors.horizontalCenter: parent.horizontalCenter
					x: 270
					y : 30
					
					text: "EGG HATCHING RESEARCH"
					font.family: "Helvetica"
					font.pointSize: 22
					color: "white"
				}
				
	Text {
					
					//anchors.horizontalCenter: parent.horizontalCenter
					x: 330
					y : 70
					
					text: "MKB - UPI PURWAKARTA"
					font.family: "Helvetica"
					font.pointSize: 15
					color: "white"
				}

	
	
	Button {
					//anchors.horizontalCenter: parent.horizontalCenter
					x: 450
					y : 600	
					text: "Tentang Pembuat"
					
					onClicked:{
						wnd5.visible = true
					}
					
				}
				
				
				
	
	Text {
					
					//anchors.horizontalCenter: parent.horizontalCenter
					x: 50
					y : 550
					
					text: "SUPPORTED BY :"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
	
	
	Image{
		  width :80
		  height : 80
          x:50
          y:580         
          source:"kelasrobot.png"
		  
	}
	
	Image{
		  width :120
		  height : 120
          x:180
          y:570         
          source:"ardumeka.png"
		  
	}
	
	
	
	Text {
					
					//anchors.horizontalCenter: parent.horizontalCenter
					x: 50
					y : 670
					
					text: "KELAS ROBOT"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
	
	
	
	
	
	
	Rectangle{
		x : 900
		y : 0
		width : 450
		height : 200
		color : "transparent"
		visible : true
		border.color: "white"
        border.width: 4
	
	
	Image{
          id: nano
		  width :70
		  height : 150
          x:30
          y:10         
          source:"nano.png"
		  
	}
	
	
	Text {
					x : 130
					y : 10
					
					text: "ARDUINO PORT :"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
				
				
	ComboBox {
		id : cb1
		x: 130
		y : 40

	}
	
	
	Text {
					x : 130
					y : 100
					
					text: "BAUD RATE :"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
				
				
	ComboBox {
		id : cb2
		x: 130
		y : 130
		model: ['9600', '115200']
	}
	
	Text {
					x : 300
					y : 40
					
					text: "CONNECTION :"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
	
	Button {
		id: connect
		x :310
		y :80
		width : 100
		height : 100
		text: ""
		font.pixelSize : 20
		
		Rectangle{
			id:connect_color
			width : parent.width
			height: parent.height
			color:"#172026"
			
			Image{
			width : parent.width
			height : parent.height
			source : "connect logo.png"
			
			}
			
			
		}
		
		
		palette {
      		button: "transparent"
			buttonText: "black"
		}
		
		onClicked:{
			if(connect_color.color == "#172026"){
				connect_color.color = "#e66b22"
				backend.connection("connected")
				backend.port_number(cb1.currentText)
				console.log(cb1.currentText)
			}else
				if(connect_color.color == "#e66b22"){
				connect_color.color = "#172026" 
				backend.connection("disconnected")
				}
		}
			
			
	}
	
	
	
	
	
	
	}

	
	
	
Button {
		id: bt00
		x :20
		y :500
		text: "ON"
		
		onClicked:{
			if(bt00.text == "ON"){
				backend.motor("ON")
				text = "OFF";
				//transient_analyzer.visible = true
				clear_buffer.visible = false
				bt_stepresponse.visible = false
			}else
				if(bt00.text == "OFF"){
					backend.motor("OFF")
					text = "ON";
					//transient_analyzer.visible = false
					clear_buffer.visible = false
					bt_stepresponse.visible = false
				}
		}
		palette { 
		button: "white"
		buttonText: "black"		}
		
	}


Button {
		id: bt_stepresponse
		x :200
		y :500
		text: "STEP RESPONSE"
		visible : false
		onClicked:{
			if(bt_stepresponse.text == "STEP RESPONSE"){
				backend.mode("STEP")
				text = "DONE";
				
			}else
				if(bt_stepresponse.text == "DONE"){
					backend.mode("PID")
					text = "STEP RESPONSE";
					//transient_analyzer.visible = false
					//clear_buffer.visible = true
				}
		}
		palette { 
		button: "white"
		buttonText: "black"		}
		
	}

	
	
	
	
	
Button {
		id: clear_buffer
		x :200
		y :500
		visible : false
		text: "clear buffer"
		onClicked:{
			backend.clear_buffer("yes")
			}
		palette { 
		button: "white"
		buttonText: "black"		
		}	
		
	}

Button {
		id: button_camera
		x :780
		y :200
		width : 90
		height : 90
		visible : false
		text: ""
		
		Image{
		width:parent.width
		height:parent.height
		source:"camera.png"
		
		}
		
		onClicked:{
		wnd2.visible = true
		}
		
		}

	
	Button {
		id: button_kwh
		x :750
		y :150
		width : 110
		height : 60
		visible : true
		text: "POWER \n CONSUMPTION"
		
		onClicked:{
		wnd3.visible = true
		}
		
		
		
	}
	
	
	Button {
		//id: button_kwh
		x :750
		y :220
		width : 110
		height : 60
		visible : true
		text: "PID \n SETTING"
		
		onClicked:{
		wnd4.visible = true
		}
		
		
		
	}
	
	
	
	
	Rectangle {
	id: radialbox
	x: 150
	y: 150
	visible: true
	width: 146
	height: 144
	color:"transparent"
	
	Text {
					x : 10
					y : 140
					
					text: "SETPOINT VALUE"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
	
	
	
	
	
	
	
	
	
	Text {
					id:text_val
					y : 50
					anchors.horizontalCenter: parent.horizontalCenter
					text: slider1.value
					font.family: "Helvetica"
					font.pointSize: 25
					color: "white"
				}
	
	RadialBar {
				
	        	id : radial1
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#26150F"
	            foregroundColor: "white"
	            dialWidth: 24

				
	            minValue: slider1.from
	            maxValue: slider1.to
	            value: slider1.value
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }
                textColor: "white"
	            
				
				
	        }
	
	
	}
	
	
	Rectangle {
	x:570
	y:150
	id: radialbox2
	visible: true
	width: 144
	height: 144
	color:"transparent"
	
	Text {
					x : 10
					y : 140
					
					text: "CONTROL SIGNAL"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}
	
	
	
	Text {
					id:text_val2
					y : 50
					anchors.horizontalCenter: parent.horizontalCenter
					text:"0" 
					font.family: "Helvetica"
					font.pointSize: 25
					color: "white"
				}
	
	RadialBar {
				
	        	id : radial2
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#26150F"
	            foregroundColor: "white"
	            dialWidth: 24

				
	            minValue: 0
	            maxValue: 100
	           // value: text_val2
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }

	            textColor: "black"
				
				
	        }
	
		
	
	
	}
	
	
	
	Rectangle{
			x: 0
			y: 350
			id : rectslider
			color : "transparent"
			width : 440
			height : 130
			anchors.leftMargin : 237.5
			anchors.bottomMargin : 50
			visible : true
			border.width : 3
			border.color : "white"
			
			Text {
					id:text_p
					//anchors.horizontalCenter: parent.horizontalCenter
					x:5
					y:10
					text: "Setpoint   :"
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
			
			
			Slider {
				id: slider1
				x:100
				y:10
				height: 20
				width: 275
				value: 37
				from : 25 
				to : 40
				stepSize: 1
				visible: true
				onValueChanged: {
				backend.setpoint(value)
		
		}
		Text {
					id:text_proportional
					x:-95
					y:30
					text: "P control  :"
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
		
		
		Slider {
				id: slider2
				//x:100
				y:30
				height: 20
				width: 275
				//value: 80
				to: 1
				stepSize: 0.0001
				visible: true
				
				onValueChanged: {
				backend.setP_control(value)
		
		}
		
				
		
	}
	
	Text {
					id:kp_val
					x:275
					y:30
					text: slider2.value.toFixed(4)
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
	
	
	
	
	Text {
					id:integral
					x:-95
					y:60
					text: "I control   :"
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
	
	
	
	Slider {
				id: slider3
				//x:100
				y:60
				height: 20
				width: 275
				//value: 80
				to: 0.15
				stepSize: 0.0001
				visible: true
				onValueChanged: {
				backend.setI_control(value)
		
		}
		
	}
	
	Text {
					id:ki_val
					x:275
					y:60
					text: slider3.value.toFixed(4)
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
	
	Text {
					id:derivative
					x:-95
					y:90
					text: "D control  :"
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
				
	
	
	
	Slider {
				id: slider4
				//x:100
				y:90
				height: 20
				width: 275
				//value: 80
				to: 0.03
				stepSize: 0.0001
				visible: true
				
				onValueChanged: {
				backend.setD_control(value)
		
		}
		
	}
	
	Text {
					id:kd_val
					x:275
					y:90
					text: slider4.value.toFixed(4)
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
	
	
	Rectangle {
            id: chart1
            x: 350
            y: -10
            width: 400
            height: 230
            visible: true
            color: "transparent"
			border.width : 3
			border.color : "white"
			
            ChartView {
                id: cv
                height: parent.height
                property double valueCH3: 0
                property double valueCH2: 0
                //theme: ChartView.ChartThemeDark
                property double valueCH4: 0
                title: ""
                legend.visible: false
                property double startTIME: 0
                property int timcnt: 0
                property double periodGRAPH: 30 //30
                property double intervalTM: 200 //200
                anchors.fill: parent
				backgroundColor:"transparent"
                
				ValueAxis {
                    id: yAxis
                    max: 45
                    min: 0
                    //labelFormat: "%d"
                    tickCount: 1
					labelsColor: "white"
                }
				
				
				ValueAxis {
                    id: yAxis1
                    max: 50
                    min: 20
                    //labelFormat: "%d"
                    tickCount: 1
					labelsColor: "white"
				}
				
				
				
				LineSeries {
					
                    id: lines1
                    name: "SETPOINT"
                    width: 5
                    color: "#FFE113"
                    axisX: DateTimeAxis {
                        id: eje
                        format: "HH:mm:ss"
                        visible:true
						labelsColor: "white"
                    }
                    axisY: yAxis
                }
				
				
                LineSeries {
                    id: lines2
                    name: "HEAT"
                    width: 5
                    color: "#16FF00"
                    axisX: eje
                    axisY: yAxis
					
                }
				
                property double valueCH1: 0
                antialiasing: true
            }

            
		}
	
	
	
	}
	}
	
	
	Rectangle {
		id:rect2
		x: 360
		y: 130
		width: 160
		height: 160
		color: "transparent"
		
		Text {
					anchors.horizontalCenter: parent.horizontalCenter
					y : 160
					
					text: "HEAT VALUE"
					font.family: "Helvetica"
					font.pointSize: 12
					color: "white"
				}

		CircularGauge {
			id: gauge2
			width: rect2.width
			height: rect2.height
			value: 23
			anchors.centerIn: parent
			minimumValue : 0
			maximumValue : 60
			//tickmarkStepSize : 1
			
			style: CircularGaugeStyle {
				id: style
				labelStepSize: Math.floor((gauge2.maximumValue - gauge2.minimumValue)/6)
				
				
				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				
				

				

				needle: Rectangle {
					y: outerRadius * 0.15
					implicitWidth: outerRadius * 0.03
					implicitHeight: outerRadius * 0.9
					antialiasing: false
					color: "white"
				}

				
				
				
			}
			
			
			
			
			Rectangle {
				id:rectsg2
				anchors.horizontalCenter: parent.horizontalCenter
				y: 120
				width: 40
				height: 20
				color: "transparent"
				Text {
					id:textgauge2
					anchors.horizontalCenter: parent.horizontalCenter
					text: Math.floor(gauge2.value)
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
			}
			
			
		
		
		}
	
	
	Rectangle{
		id : setting_page
		x : 540
		y : 100
		width : 450
		height : 450
		color : "transparent"
		visible : true
		border.color: "white"
        border.width: 4
		
		
		Text {
					
					y : 10
					anchors.horizontalCenter: parent.horizontalCenter
					text:"INCUBATOR PARAMETER" 
					font.family: "Helvetica"
					font.pointSize: 15
					color: "white"
				}
	
	Image{
		  width :60
		  height : 80
          x:10
          y:50         
          source:"humidity.png"
		  
	}
	
	Text {
					id : humidity
                    x:80
					y : 55
                    font.pointSize: 35
                    color: "white"
                    text: "0%"
					font.family : "HarmoniaSansW01-Bold"
                }
	
	
	Image{
		  width :100
		  height : 80
          x:220
          y:50         
          source:"thermometer.png"
		  
	}
	
	Text {

                    x:300
					y : 55
                    font.pointSize: 33
                    color: "white"
                    text: (gauge2.value).toFixed(1) + "°C"
					font.family : "HarmoniaSansW01-Bold"
                }
	
	
	
	Image{
		  width :80
		  height : 80
          x:0
          y:160         
          source:"humidifier.png"
		  
	}
	
	Text {
					id : humidifier_label
                    x:80
					y : 170
                    font.pointSize: 35
                    color: "white"
                    text: "0 %"
					font.family : "HarmoniaSansW01-Bold"
                }
	
	
	Image{
		  width :70
		  height : 70
          x:240
          y:160         
          source:"fan.png"
		  
	}
	
	Text {
                    x:320
					y : 160
                    font.pointSize: 35
                    color: "white"
                    text: (slider_fan.value).toFixed(0) + "%"
					font.family : "HarmoniaSansW01-Bold"
                }
	
	
	
	Text {
					x : 10
					y : 260
					text:"HUMIDITY SET:" 
					font.family: "Helvetica"
					font.pointSize: 15
					color: "white"
				}
	
	
	
	CircularSlider {
                id: slider_input
				//anchors.horizontalCenter: parent.horizontalCenter
				x : 10
				y : 310
                value: 55
                //onValueChanged: handlePage.newVal = value
                width: 150
                height: 150
                startAngle: 40
                endAngle: 320
                rotation: 180
                trackWidth: 5
                progressWidth: 20
                minValue: 0
                maxValue: 100
                progressColor: "white"
                capStyle: Qt.FlatCap

                handle: Rectangle {
                    transform: Translate {
                        x: (slider_input.handleWidth - width) / 2
                        y: slider_input.handleHeight / 2
                    }

                    width: 10
                    height: slider_input.height / 2
                    color: "white"
                    radius: width / 2
                    antialiasing: true
					border.width : 3
					border.color : "#6B441C"
                }

                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -40
                    rotation: 180
                    font.pointSize: 20
                    color: "white"
                    text: Number(slider_input.value).toFixed()
					font.family : "HarmoniaSansW01-Bold"
                }
            }
          
	
	Button {
	id : fan_mode
	x : 240
	y : 260
	height : fan_status.height + 10
	width : 170
	checkable : true
	
	Rectangle{
		id : fan_mode_color
		height : parent.height
		width : parent.width
		color : "#df1c39"
		border.width : 1
		border.color : "white"
	}
	
	Text {
					id : fan_status
					anchors.horizontalCenter: parent.horizontalCenter
					text:"FAN SET: MANUAL" 
					font.family: "Helvetica"
					font.pointSize: 15
					color: "white"
				}
	
	onClicked :{
		if (fan_mode.checked == true){
			fan_status.text = "FAN SET: AUTO" 
			slider_fan.interactive = false
		}
		
		if (fan_mode.checked == false){
			fan_status.text = "FAN SET: MANUAL" 
			slider_fan.interactive = true
		}
		
	}
	
	}
	
	CircularSlider {
                id: slider_fan
				
				x : 230
				y : 310
                value: 0
                //onValueChanged: handlePage.newVal = value
                width: 150
                height: 150
                startAngle: 40
                endAngle: 320
                rotation: 180
                trackWidth: 5
                progressWidth: 20
                minValue: 0
                maxValue: 100
                progressColor: "#16FF00"
                capStyle: Qt.FlatCap

                handle: Rectangle {
                    transform: Translate {
                        x: (slider_fan.handleWidth - width) / 2
                        y: slider_fan.handleHeight / 2
                    }

                    width: 10
                    height: slider_fan.height / 2
                    color: "white"
                    radius: width / 2
                    antialiasing: true
					border.width : 3
					border.color : "#6B441C"
                }

                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -40
                    rotation: 180
                    font.pointSize: 20
                    color: "white"
                    text: Number(slider_fan.value).toFixed()
					font.family : "HarmoniaSansW01-Bold"
                }
            }
            
	
	
	
	
	}
	
	
	}
	
	
	Window {
        id: "wnd2"
        visible: false
		color : "#745433"
		title:"WEBCAM CAMERA"
		width: 500
		height: 500
		flags:Qt.Dialog
		
		Rectangle{
		y: 50
		width : 300
		height : 300
		anchors.horizontalCenter: parent.horizontalCenter
		//anchors.verticalCenter: parent.verticalCenter
		
		Rectangle{
			id : cam_rect
			anchors.horizontalCenter: parent.horizontalCenter
			width: 300
			height: 300
			visible : false
			
			CVItem  {
				id: imageWriter
				anchors.fill: parent
				image: capture.image
			}
	
	

    CVCapture{
        id: capture
        index: 0
        filters: []//[max_rgb_filter, gray_filter]
        Component.onCompleted: capture.stop()
    }
	}
	
		
		
		}
		
		Button{
		id : reconnect_button
		x: 300
		y: 450
		text:"Camera Switch"
		checkable : true
		
		onClicked:{
			if (reconnect_button.checked == true){
				capture.start()
				cam_rect.visible = true
			} else {
				capture.stop()
				cam_rect.visible = false
			}
		}
		
		}
		
		
		Button{
			id : capture_signal
			x: 100
			y: 370
			width : 300
			height : 70
			text:"capture"
			visible : reconnect_button.checked
			checkable : false
			onClicked:{
				capture.signal("1")
			}
	
		}
		
		
		ComboBox {
			id : cb_camera
			x: 100
			y : 450
			width : 180
			model: ['webcam internal', 'usb camera']
		}
		
		
		onClosing: {
        capture.stop()
		cam_rect.visible = false
		reconnect_button.checked = false
		capture_signal.visible = false
		}
    }
	
	Window {
        id: "wnd3"
        visible: false
		color : "#1F2226"
		title:"POWER CONSUMTION"
		width: 600
		height: 600
		flags:Qt.Dialog
		
				
		Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					y : 10
					
					text: "POWER CALCULATION"
					font.family: "Helvetica"
					font.pointSize: 22
					color: "white"
		}
		
		Rectangle {
            id: chart2
            x: 0
            y: 70
            width: 600
            height: 250
            visible: true
            color: "transparent"
			border.width : 3
			border.color : "white"
			
            ChartView {
                id: cv3
                height: parent.height
                property double valueCH3: 0
                property double valueCH2: 0
                //theme: ChartView.ChartThemeDark
                property double valueCH4: 0
                title: ""
                legend.visible: false
                property double startTIME: 1
                property int timcnt: 0
                property double periodGRAPH: 1000 //30
                property double intervalTM: 10000 //200
                anchors.fill: parent
				backgroundColor:"transparent"
                
				ValueAxis {
                    id: yAxis3
                    max: 120
                    min: 0
                    //labelFormat: "%d"
                    tickCount: 1
					labelsColor: "white"
                }
				
				
				LineSeries {
                    id: lines3
                    name: "POWER"
                    width: 5
                    color: "white"
                    axisX: DateTimeAxis {
                        
                        format: "HH:mm:ss"
                        visible:true
						labelsColor: "white"
                    }
                    axisY: yAxis3
                }
				
				
                property double valueCH1: 0
                antialiasing: true
            }

           
		}
	
	
		
		
		
		
		Text {
					id : energy_label
					anchors.horizontalCenter: parent.horizontalCenter
					y : 340
					
					text: "TOTAL POWER CONSUMPTION : 666 kWH"
					font.family: "Helvetica"
					font.pointSize: 16
					color: "white"
		}
		
		
		
	Rectangle {
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 10
	y:380
	id: radialbox3
	visible: true
	width: 180
	height: 180
	color:"transparent"
	
	Text {
					anchors.horizontalCenter: parent.horizontalCenter
					y : 170
					
					text: "VOLTAGE"
					font.family: "Helvetica"
					font.pointSize: 16
					color: "white"
				}
	
	
	
	Text {
					
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					text: radial3.value
					font.family: "Helvetica"
					font.pointSize: 25
					color: "white"
				}
	
	RadialBar {
	        	id : radial3
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#1D7BE3"
	            foregroundColor: "white"
	            dialWidth: 24
				value : 220
	            minValue: 0
	            maxValue: 250
	           // value: text_val2
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }

	            textColor: "black"	
	        }
	}
	
	
	
	Rectangle {
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 200
	y:380
	id: radialbox4
	visible: true
	width: 180
	height: 180
	color:"transparent"
	
	Text {
					anchors.horizontalCenter: parent.horizontalCenter
					y : 170
					
					text: "CURRENT"
					font.family: "Helvetica"
					font.pointSize: 16
					color: "white"
				}
	
	
	
	Text {
					id : current_val
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					text: radial4.value/1000
					font.family: "Helvetica"
					font.pointSize: 25
					color: "white"
				}
	
	RadialBar {
	        	id : radial4
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#F3B72F"
	            foregroundColor: "white"
	            dialWidth: 24
				
				value : 1500
				
	            minValue: 0
	            maxValue: 2000
	           // value: text_val2
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }

	            textColor: "black"	
	        }
	}
	
	
	Rectangle {
	//anchors.horizontalCenter: parent.horizontalCenter
	x : 400
	y:380
	id: radialbox5
	visible: true
	width: 180
	height: 180
	color:"transparent"
	
	Text {
					anchors.horizontalCenter: parent.horizontalCenter
					y : 170
					
					text: "POWER"
					font.family: "Helvetica"
					font.pointSize: 16
					color: "white"
				}
	
	
	
	Text {
					
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					text: radial5.value
					font.family: "Helvetica"
					font.pointSize: 25
					color: "white"
				}
	
	RadialBar {
	        	id : radial5
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "#F55959"
	            foregroundColor: "white"
	            dialWidth: 24
				
				value : 0
				
	            minValue: 0
	            maxValue: 230
	           // value: text_val2
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }

	            textColor: "black"	
	        }
	}
	
		
		
		
		
		
	}
	
	
	
	Window {
        id: "wnd4"
        visible: false
		color : "#1F2226"
		title:"PID OPTIONS"
		width: 500
		height: 300
		flags:Qt.Dialog
		
		Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					y : 10
					
					text: "PID OPTIONS"
					font.family: "Helvetica"
					font.pointSize: 22
					color: "white"
		}
		
		Button {
		id : standard
		x :50
		y :70
		width : 90
		height : 90
		checkable : true
		checked : true
		text: "STANDARD"
		
		onClicked:{
			aggresive.checked = false
			conservative.checked = false
			slider2.value = 0.2
			slider2.to = 0.5
			slider3.value = 0.11
			slider3.to = 0.5
			slider4.value = 0.05
			slider4.to = 0.5
			
		}
		
		
		}
		
		
		Button {
		id : aggresive
		x :200
		y :70
		width : 90
		height : 90
		checkable : true
		text: "AGRRESIVE"
		
		onClicked:{
			standard.checked = false
			conservative.checked = false
			slider2.value = 0.5
			slider2.to = 0.5
			slider3.value = 0.31
			slider3.to = 0.5
			slider4.value = 0.1
			slider4.to = 0.5
		}
		
		}
		
		Button {
		id : conservative
		x :350
		y :70
		width : 95
		height : 90
		checkable : true
		text: "CONSERVATIVE"
		
		onClicked:{
			aggresive.checked = false
			standard.checked = false
			slider2.value = 0.08
			slider2.to = 0.5
			slider3.value = 0.01
			slider3.to = 0.5
			slider4.value = 0.5
			slider4.to = 0.5
		
		}
		
		}
		
		
		
	}
	
	
	
	
	
Window {
	id : wnd5
	width: 500
	//maximumWidth : 1280
	//minimumWidth : width
    height: 350
	//maximumHeight : 800
	//minimumHeight : height
	title:"Tentang Pembuat"
	color : "white"
    visible: false
    //flags: Qt.WindowMaximized //Qt.Dialog
	
	Item {
        id: page
        anchors.fill: parent
        width:root.width
        height: root.height
        
		
		ScrollView {
            id:scrollView
            anchors.fill:parent
		
			
			
            
		style: ScrollViewStyle {
			handle: Rectangle {
			x: 0
            implicitWidth: 10
            implicitHeight: 30
            color: "red"
			
        }
		
		minimumHandleLength : 10
		
        scrollBarBackground: Rectangle {
            implicitWidth: 10
            implicitHeight: 30
            color: "transparent"
        }
        decrementControl: Rectangle {
            implicitWidth: 0
            implicitHeight: 0
            color: "transparent"
        }
        incrementControl: Rectangle {
            implicitWidth: 0
            implicitHeight: 0
            color: "transparent"
        }
    }
			
            Column{
                width:parent.width
                spacing:4
                
				Rectangle{
					
					width: 500
					height: 120
					color: "#024959"
					
					Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					y : 10
					
					text: "TIM EGG HATCHING RESEARCH"
					font.family: "Helvetica"
					font.pointSize: 18
					color: "white"
				}
				
				
				Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					y : 40
					
					text: "MKB - UPI PURWAKARTA"
					font.family: "Helvetica"
					font.pointSize: 14
					color: "white"
				}
				
				Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					y : 60
					
					text: "2023"
					font.family: "Helvetica"
					font.pointSize: 14
					color: "white"
				}
				
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Image{
					  x:0
					  y:0
					  width : 100
					  height : parent.height
					  source : "kangdiky.png"
						
					}
					
					Text{
						x: 120
						y : 30
						text: "Diky Zakaria, M.T (Team Leader) \nDosen, Pakar Sistem Kendali"
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Image{
					  x:0
					  y:0
					  width : 100
					  height : parent.height
					  source : "husni.png"
						
					}
					
					Text{
						x: 120
						y : 30
						text: "Muhammad Husni \nPython Programmer"
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Image{
					  x:0
					  y:0
					  width : 100
					  height : parent.height
					  source : "ajang.png"
						
					}
					
					Text{
						x: 120
						y : 30
						text: "Ajang Rahmat \nIoT & Image Processing Developer"
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Text{
						x: 120
						y : 30
						text: "Ali \nMechanical Designer"
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Text{
						x: 120
						y : 30
						text: "Bilal \n ..."
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Text{
						x: 120
						y : 30
						text: "Dany \n..."
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
				}
				
				Rectangle{
					
					width: 500
					height: 150
					color: "#024959"
					
					Text{
						x: 120
						y : 30
						text: "Fauzie \n..."
						font.family: "Helvetica"
						font.pointSize: 16
						color: "white"
						
					}
					
				}
				
			
			}

        }
    
	
	
	}	

	
	
}
	
	
	
	
	
	Component.onCompleted: {
		cv.startTIME = backend.get_tiempo()*1000
		cv3.startTIME = backend.get_tiempo()*1000
		
	}
	
	
	
	
	
	
	Timer{
		id:guitimer
		interval: 200
		repeat: true
		running: true
		onTriggered: {
			gauge2.value = backend.sensor_val_read()
			text_val2.text = backend.power_val_read()
			radial2.value = backend.power_val_read()
			cb1.model = backend.port_val_read()
			humidity.text = backend.humidity() + " %"
			radial3.value = backend.voltage()
			radial4.value = backend.current()
			radial5.value = backend.power()
			energy_label.text = "used power : " + backend.energy() + " kWH"
			
			backend.fan_mode(fan_mode.checked)
			
			backend.fan_gauge(slider_fan.value)
			
			if (fan_mode.checked == true){
				slider_fan.value = backend.fan_speed()
			}
			
			//console.log(slider_input.value - backend.humidity())
			
			if (slider_input.value - backend.humidity() > 0){
				backend.humidifier(slider_input.value - backend.humidity())
			
			} else {
				backend.humidifier(0)
			}
			
			humidifier_label.text = backend.humidifier_display() + "%"
			
		}
		
		
	}
	
	
	
	Timer {
                id: tm
                repeat: true
				interval : cv.intervalTM
                running: true
                onTriggered: {
                        cv.timcnt = cv.timcnt + 1
                        //cv1.timcnt = cv1.timcnt + 1
                        cv.valueCH1 = parseFloat(slider1.value)
                        cv.valueCH2 = parseFloat(gauge2.value)
                        cv3.valueCH1 = radial5.value//parseFloat(slider1.value)
                        
						
						if (lines1.count>cv.periodGRAPH*1000/cv.intervalTM){
							lines1.remove(0)
							lines2.remove(0)
							lines3.remove(0)
							
						}

                        lines1.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH1)
                        lines2.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH2)
						lines3.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv3.valueCH1)
						
						
						lines1.axisX.min = new Date(cv.startTIME - cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
						lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
			
                        lines2.axisX.min = new Date(cv.startTIME - cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
                        lines2.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
						
						lines3.axisX.min = new Date(cv.startTIME - cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
                        lines3.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
						
						
                    }
            }
        
}