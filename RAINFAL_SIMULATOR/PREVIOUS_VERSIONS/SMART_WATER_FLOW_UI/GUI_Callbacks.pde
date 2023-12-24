

/*************************************************/

/*------------------------------------------------*/
public void CONNECT() {
  serial_init();
}
/*------------------------------------------------*/

public void DATA_ON() {
  if (dataONTicker !=0) {
    println("Streaming DATA_ON");
    myPort.write('1');
    customize_button_color(dataON, GREEN);
    customize_button_color(dataOFF, RED);
  }
  dataONTicker++;
}

/*------------------------------------------------*/
public void DATA_OFF() {
  if (dataOFFTicker !=0) {
    println("Streaming DATA_OFF");
    myPort.write('2');
    customize_button_color(dataOFF, GREEN);
    customize_button_color(dataON, RED);
  }
  dataOFFTicker++;
}

/*------------------------------------------------*/
public void VALVE_OPEN() {
  if (valveOpenTicker !=0) {
    println("Command VALVE_OPENED");
    myPort.write('3');
    customize_button_color(valveOpen, GREEN);
    customize_button_color(valveClose, RED);
  }
}
/*------------------------------------------------*/
public void VALVE_CLOSE() {
  if (valveCloseTicker !=0) {
    println("Command VALVE_CLOSED");
    myPort.write('4');
    customize_button_color(valveClose, GREEN);
    customize_button_color(valveOpen, RED);
  }
}
/*------------------------------------------------*/
//public void AUTO_MODE(){
//  myPort.write('9');
//  println("AUTOMATIC_MODE 123");
//}

public void MANUAL_MODE(){
  myPort.write('M');
}
/*------------------------------------------------*/
/*------------------------------------------------*/
/*------------------------------------------------*/
/*------------------------------------------------*/

void slider(float value) {
  desiredValvePosition = value;
  String message = "D:" + str(value);
  myPort.write(message);
  println("a slider event.value = "+value);
}
