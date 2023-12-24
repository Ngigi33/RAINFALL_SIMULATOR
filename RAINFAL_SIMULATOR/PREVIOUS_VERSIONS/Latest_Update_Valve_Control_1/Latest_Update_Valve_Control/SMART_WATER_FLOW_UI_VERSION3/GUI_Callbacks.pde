/*************************************************/
/*
    CALL BACK functions for each of the GUI buttons
 These functions have the same name as their GUI
 button counterparts. Once the button is pressed,
 the associated function is called and run.
 */
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

    if (system_mode == MANUAL) {
      valveOpenTicker++;
      valveCloseTicker++;
      addticker=0;
      minusticker=0;
      customize_button_color(addValve, GRAY);
      customize_button_color(subValve, GRAY);
    }
  }
}
/*------------------------------------------------*/
public void VALVE_CLOSE() {
  if (valveCloseTicker !=0) {
    println("Command VALVE_CLOSED");
    myPort.write('4');
    //myPort.write(4);
    customize_button_color(valveClose, GREEN);
    customize_button_color(valveOpen, RED);
  }


  if (system_mode == MANUAL) {
    valveOpenTicker++;
    valveCloseTicker++;
    addticker=0;
    minusticker=0;
    customize_button_color(addValve, GRAY);
    customize_button_color(subValve, GRAY);
  }
}
/*------------------------------------------------*/
//public void AUTO_MODE(){
//  myPort.write('9');
//  println("AUTOMATIC_MODE 123");
//}

/*------------------------------------------------*/

public void MANUAL_MODE() {
  manualMode.setColorBackground(GREEN);
  println("system_mode = MANUAL");
  system_mode = MANUAL;
  valveOpenTicker++;
  valveCloseTicker++;
  customize_button_color(stopValve, GRAY);
  customize_button_color(autoMode, GRAY);
  customize_button_color(valveOpen, DEFAULT_BLUE);
  customize_button_color(valveClose, DEFAULT_BLUE);
  myPort.write('5');
  delay(10);
  myPort.write(0);
}
/*------------------------------------------------*/

public void SLIGHT_OPEN() {
  if (system_mode == MANUAL) {
    println("Command: VALVE_SLIGHTLY_OPENED");

    valveOpenTicker=0;
    valveCloseTicker = 0;
    customize_button_color(addValve, GREEN);
    customize_button_color(subValve, RED);
    customize_button_color(valveClose, GRAY);
    customize_button_color(valveOpen, GRAY);

    myPort.write('6');
    delay(30);
    myPort.write(0);
  }
}
/*------------------------------------------------*/

public void SLIGHT_CLOSE() {
  if (system_mode == MANUAL) {
    println("Command: VALVE_SLIGHTLY_CLOSED");

    valveOpenTicker=0;
    valveCloseTicker = 0;
    customize_button_color(subValve, GREEN);
    customize_button_color(addValve, RED);
    customize_button_color(valveClose, GRAY);
    customize_button_color(valveOpen, GRAY);

    myPort.write('7');
    delay(30);
    myPort.write(0);
  }
}
/*------------------------------------------------*/

public void STOP_VALVE() {
  println("Command STOP_VALVE");

  valveOpenTicker=0;
  valveCloseTicker = 0;
  minusticker=0;
  addticker=0;
  customize_button_color(valveClose, GRAY);
  customize_button_color(valveOpen, GRAY);
  customize_button_color(subValve, GRAY);
  customize_button_color(addValve, GRAY);
  customize_button_color(manualMode, GRAY);
  customize_button_color(stopValve, GREEN);
  system_mode = STOP;

  myPort.write('8');
  delay(50);
  myPort.write(8);
}

/*------------------------------------------------*/

public void AUTO_MODE() {
  autoMode.setColorBackground(GREEN);
  println("system_mode = AUTOMATIC");
  system_mode = AUTOMATIC;
  valveOpenTicker=0;
  valveCloseTicker=0;
  customize_button_color(stopValve, GRAY);
  customize_button_color(manualMode, GRAY);

  myPort.write('9');
  delay(10);
  myPort.write(0);
}
/*------------------------------------------------*/

public void START_AUTO() {
  if (system_mode == AUTOMATIC) {
    customize_button_color(autoStart, GREEN);
    customize_button_color(autoStop, RED);
    customize_button_color(valveClose, GRAY);
    customize_button_color(valveOpen, GRAY);

    msg = "#"+cp5.get(Textfield.class, "L_MIN").getText();
    println(msg);
    myPort.write(msg);
    delay(10);
  }
}

/*------------------------------------------------*/
public void STOP_AUTO() {
  if (system_mode == AUTOMATIC) {
    customize_button_color(autoStop, GREEN);
    customize_button_color(autoStart, RED);
    customize_button_color(valveClose, GRAY);
    customize_button_color(valveOpen, GRAY);
    cp5.get(Textfield.class, "L_MIN").clear();
    msg = "#,S";
    println(msg);
    myPort.write(msg);
    delay(10);
  }
}

/*------------------------------------------------*/

void slider(float value) {
  desiredValvePosition = value;
  String message = "D:" + str(value);
  myPort.write(message);
  println("a slider event.value = "+value);
}
