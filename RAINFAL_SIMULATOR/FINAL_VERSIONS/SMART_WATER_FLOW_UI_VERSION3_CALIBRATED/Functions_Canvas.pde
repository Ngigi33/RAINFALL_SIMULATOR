/*************************************************/
/*
  Main Function that controls the GUI aesthetics and visual elements
 */
/*************************************************/


void draw_canvas() {
  // Draw the background
  background(NAVY);

  // Draw the title block and wording
  fill(BLUE);
  rect(0, 0, width, 40);
  noStroke();
  fill(WHITE);
  textSize(32);
  text("Flow Control Project", (width/2)-150, 35);

  // Draw the general info section
  textSize(20);
  text("Serial Port:", 50, 80);
  text("DATA Stream:", 50, 150);
  text("Incoming DATA:", 300, 160);
  text("FlowRate (L/MIN):", 300, 210);
  text(serialBuffer[0], 450, 210);
  text("Valve Position :", 315, 240);
  text((100-int(serialBuffer[3])), 450, 240);
  text("% OPEN",485,240);
  text("Valve Status :", 330, 270);

  switch(serialBuffer[2]) {
  case "3":
    valveStatus = "OPENED";
    break;
  case "4":
    valveStatus = "CLOSED";
    break;
  case "5":
    valveStatus = "Active_OPENING";
    break;
  case "6":
    valveStatus = "Active_CLOSING";
    break;
  case "7":
    valveStatus = "STOPPED";
    break;
  default:
    break;
  }
  text(valveStatus, 450, 270);

  // Draw the Control mode Title
  fill(BLUE);
  rect(0, 300, width, 35);
  noStroke();
  fill(WHITE);
  textSize(32);
  text("Control Modes: ", 30, 330);

  // Draw the Control section
  text("VALVE CONTROL", 70, 630);
  textSize(20);
  text("INPUT L/HR POSITION :", 500, 515);
}



void update_canvas() {
  j=int(map(float(serialBuffer[3]), 0, 100, 100, 0));
  cp5.getController("valve_position").setValue(j);
}
