import controlP5.*;
ControlP5 cp5;

DropdownList serialList;
Button connectSerial, dataON, dataOFF, manualMode, autoMode;
Button valveOpen, valveClose, autoStart, autoStop, addValve, subValve, stopValve;

int connectSerialTicker, dataONTicker, dataOFFTicker, stopticker = 0;
int valveOpenTicker, valveCloseTicker = 0;
int addticker, minusticker=0;
float desiredValvePosition = 0;


Slider valveOperateManual, valveOperateAuto;
/*------------------------------------------------*/
void gui_init() {

  /*+++++++++++*/
  connectSerial = cp5.addButton("CONNECT")
    .setValue(0)
    .setPosition(275, 65)
    .setSize(100, 50)
    ;
  /*+++++++++++*/
  serialList = cp5.addDropdownList("serial_ports")
    .setPosition(150, 65)
    ;
  /*+++++++++++*/
  customize_droplist(serialList);
  /*+++++++++++*/

  dataON = cp5.addButton("DATA_ON")
    .setValue(0)
    .setPosition(50, 170)
    .setSize(70, 50)
    ;
  /*+++++++++++*/
  dataOFF = cp5.addButton("DATA_OFF")
    .setValue(0)
    .setPosition(150, 170)
    .setSize(70, 50)
    ;
  /*+++++++++++*/

  manualMode = cp5.addButton("MANUAL_MODE")
    .setValue(0)
    .setPosition(50, 365)
    .setSize(170, 50)
    .setColorBackground(GRAY)
    ;

  /*+++++++++++*/
  autoMode = cp5.addButton("AUTO_MODE")
    .setValue(0)
    .setPosition(500, 365)
    .setSize(170, 50)
    .setColorBackground(GRAY)
    ;

  /*+++++++++++*/
  valveOpen = cp5.addButton("VALVE_OPEN")
    .setValue(0)
    .setPosition(50, 500)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  valveClose = cp5.addButton("VALVE_CLOSE")
    .setValue(0)
    .setPosition(150, 500)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  addValve = cp5.addButton("SLIGHT_OPEN")
    .setValue(0)
    .setPosition(50, 650)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  subValve = cp5.addButton("SLIGHT_CLOSE")
    .setValue(0)
    .setPosition(150, 650)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  /*+++++++++++*/
  stopValve = cp5.addButton("STOP_VALVE")
    .setValue(0)
    .setPosition(250, 650)
    .setSize(70, 50)
    ;



  /*+++++++++++*/
  cp5.addTextfield("L_MIN")
    .setPosition(500, 530)
    .setSize(100, 50)
    .setFont(createFont("arial", 30))
    .setFocus(true)
    .setColor(color(255, 0, 0))
    ;

  /*+++++++++++*/
  autoStart = cp5.addButton("START_AUTO")
    .setValue(0)
    .setPosition(500, 650)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  autoStop = cp5.addButton("STOP_AUTO")
    .setValue(0)
    .setPosition(600, 650)
    .setSize(70, 50)
    .setColorBackground(GRAY)
    ;
  /*+++++++++++*/
  valveOperateManual = cp5.addSlider("valve_position")
    .setPosition(50, 450)
    .setSize(630, 30)
    .setRange(0, 100)
    .setNumberOfTickMarks(101)
    ;

  ///*+++++++++++*/
  //valveOperateAuto = cp5.addSlider("valve_position_Auto")
  //  .setPosition(480, 450)
  //  .setSize(200, 20)
  //  .setRange(0, 10)
  //  //.setColorBackground(GRAY)
  //  .setNumberOfTickMarks(11)
  //  .setValue(j)
  //  ;
}
/*------------------------------------------------*/
void customize_droplist(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(30);
  ddl.setHeight(120);
  ddl.setBarHeight(20);
  ddl.getCaptionLabel().set("Select Serial Port");
  String listPortName = "No Serial Port";
  for (int i=0; i<Serial.list().length; i++) {
    listPortName = Serial.list()[i];
    ddl.addItem(listPortName, i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
/*------------------------------------------------*/
void customize_connect_button(Button button) {
  // a convenience function to customize a DropdownList
  button.setColorBackground(GREEN);
  button.setLabel("CONNECTED");
}
/*------------------------------------------------*/
void customize_button_color(Button button, color tint) {
  // a convenience function to customize a DropdownList
  button.setColorBackground(tint);
}
/*------------------------------------------------*/
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    // println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    String callingList = theEvent.getController().getName();
    float calledValue = theEvent.getController().getValue();
    // println("event from controller : "+calledValue+" from "+callingList);

    if (callingList == "serial_ports") {
      portName = Serial.list()[int(calledValue)];
    }
  }
}
/*------------------------------------------------*/
void serial_init() {
  if (connectSerialTicker !=0) {
    println("Connecting to Arduino");
    if (portName != " ") {
      myPort = new Serial(this, portName, 115200);
      myPort.bufferUntil('\n');
    } else {
      println("ERROR: problem connecting to Arduino");
      println("Try selecting a com port");
    }
  }
  connectSerialTicker ++;
}
/*------------------------------------------------*/
