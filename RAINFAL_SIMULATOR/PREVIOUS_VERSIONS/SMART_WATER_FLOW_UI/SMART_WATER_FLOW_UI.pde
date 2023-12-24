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
String Vstatus = "NO CONNECTION";
float flowRate = 0;
float j=0;
int k;
int b=0;
int pressed=0;

color GREEN = #6AAB9C;
color ORANGE = #FA9284;
color RED = #E06C78;
color BLUE = #5874DC;
color NAVY = #384E78;
color WHITE = #DDDDDA;
color GRAY = #878787;

String[] serialBuffer = {"0", "0", "0", "0"};

ArrayList<TEXTBOX> textboxes= new ArrayList<TEXTBOX>();
boolean send=false;
String msg="";

void setup () {
  size(800, 800);        // window size
  cp5 = new ControlP5(this);
  gui_init();
  InitLayout();
}

void InitLayout()
{
  TEXTBOX receiver = new TEXTBOX();
  receiver.W=70;
  receiver.H=50;
  receiver.X=480;
  receiver.Y=650;

  textboxes.add(receiver);
}

void mousePressed() {
  for ( TEXTBOX t : textboxes)
  {
    t.PRESSED(mouseX, mouseY);
  }
}

void keyPressed()
{
  for ( TEXTBOX t : textboxes)
  {
    if (t.KEYPRESSED(key, keyCode))
    {
      send=true;
      int caster=int(textboxes.get(0).Text)+10;
      msg = str(caster);
    }
  }
}


void draw () {
  background(NAVY);
  fill(BLUE);
  rect(0, 0, width, 40);
  noStroke();
  fill(WHITE);
  textSize(32);
  text("Flow Control Project", (width/2)-150, 35);

  j=map(float(serialBuffer[3]), 0, 100, 10, 0);
  k=int(j);
  textSize(20);
  text("Serial Port:", 50, 80);
  text("DATA Stream:", 50, 150);
  text("Incoming DATA:", 300, 160);
  text("FlowRate (L/HR):", 300, 210);
  text(serialBuffer[0], 450, 210);
  cp5.getController("valve_position_Manual").setValue(k);
  text("Valve Position :", 315, 240);
  text(serialBuffer[3], 450, 240);
  text("Valve Status :", 330, 270);
  text("VALVE CONTROL", 70, 630);
  switch(serialBuffer[2]) {
  case "2":
    Vstatus = "OPENED";
    break;
  case "3":
    Vstatus = "CLOSED";
    break;
  case "4":
    Vstatus = "ACTIVE";
    break;
  default:
    break;
  }
  text(Vstatus, 450, 270);


  fill(BLUE);
  rect(0, 300, width, 35);
  noStroke();
  fill(WHITE);
  textSize(32);
  text("Control Modes: ", 30, 330);


  //println(k);


  if (pressed==1)
  {
    if (minusvalve.isPressed())
    {
      //VALVE_MINUS();
      println("hello");
      println("Command VALVE_SLIGHTLY_CLOSED");
      myPort.write('7');
      delay(500);
      myPort.write(7);
    }
    if (addvalve.isPressed())
    {
      //VALVE_MINUS();
      println("hello");
      println("Command VALVE_SLIGHTLY_OPENED");
      myPort.write('6');
      delay(500);
      myPort.write(6);
    }
  }

  if (stopvalve.isPressed())
  {
    println("Command STOP_VALVE");
    myPort.write('8');
    myPort.write(8);
  }


  if (autoMode.isPressed())
  {
    delay(200);
    myPort.write('9');
    myPort.write(9);
    println("AUTOMATIC_MODE_ui");
  }

  textSize(20);
  text("INPUT L/HR POSITION :", 480, 630);
  //rect(530, 650, 120, 50, 28);

  //user_input();

  for (TEXTBOX t : textboxes)
  {
    t.DRAW();
  }
  if (send)
  {
    println(msg);
    myPort.write(msg);
    delay(100);
    send=false;
  }
}
