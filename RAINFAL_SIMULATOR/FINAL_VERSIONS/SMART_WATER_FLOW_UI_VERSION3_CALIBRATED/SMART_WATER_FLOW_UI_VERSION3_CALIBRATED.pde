/*************************************************/
/*
   Test code for Sending a command to the arduino and
 receiveing a data stream from it
 */
/*************************************************/
import processing.serial.*;
Serial myPort;
String val;     // Data received from the serial port
boolean firstContact = false;
int messageToSend = 0;
String portName = " ";
String valveStatus = "NO CONNECTION";
float flowRate = 0;
float j=0;
int b=0;

boolean start;
int system_mode=0;
int STOP = 0;
int MANUAL = 1;
int AUTOMATIC = 2;

color GREEN = #6AAB9C;
color ORANGE = #FA9284;
color RED = #E06C78;
color BLUE = #5874DC;
color NAVY = #384E78;
color WHITE = #DDDDDA;
color GRAY = #878787;
color DEFAULT_BLUE = #082C5C;

String[] serialBuffer = {"0", "0", "0", "0" };
boolean send=false;
String msg="";

void setup () {
  size(800, 800);        // window size
  cp5 = new ControlP5(this);
  gui_init();
}


void draw () {

  draw_canvas();
  update_canvas();

}
