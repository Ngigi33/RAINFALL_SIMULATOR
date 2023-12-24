
/*-----------------------------------*/
void process_serial() {
  val.trim();
  if (val.charAt(0) == '#') {  // Check if the first character is '#'
    Serial.println(val);
    val.remove(0, 1);  // Remove the '#' character from the string
    Serial.println(val);
    if (val.equals('S') == false) {
      cast = val.toInt();  // Convert the remaining string to an integer
      Serial.print("Desired Flow:");
      Serial.println(cast);
      valveMode = STARTPID;
    } else {
      valveMode = STOPPID;
    }
  } else {
    menuChoice = val.toInt();
    Serial.print("menuChoice:");
    Serial.println(menuChoice);
  }
}

/*-----------------------------------*/
void get_user_input() {
  if (Serial.available() > 0) {
    val = Serial.readStringUntil('\n');
    if (val != 0) {
      process_serial();
    }
  }
}

/*-----------------------------------*/
void process_user_input() {
  if ((menuChoice != 0) && (menuChoice <= 10)) {
    //Serial.println(menuChoice);
    switch (menuChoice) {
      case 1:
        streamFlag = true;
        break;

      case 2:
        streamFlag = false;
        break;

      case 3:
        // Fully open the valve
        full_open_valve();
        break;

      case 4:
        // Fully close the valve
        full_close_valve();
        break;

      case 5:
        valveMode = MANUAL;
        break;

      case 6:
        slight_flag = true;
        slight_open_valve();
        delay(200);
        break;

      case 7:
        slight_flag = true;
        slight_close_valve();
        delay(200);
        break;

      case 8:
        Serial.println("8");
        stop = true;
        stop_valve();

      case 9:
        valveMode = AUTOMATIC;

      default:
        streamFlag = streamFlag;
        //Serial.println("S");
    }
  }

  menuChoice = 0;
}
/*-----------------------------------*/

/*
  Current Serial Commands:8
  1: *** Stream Data - True
  2: *** Stream Data - False
  3: *** Open Fully Valve
  4: *** Close Fully Valve
  5: *** Calibrate Flowmeter
  6: Opening Pulse Valve (150)
  7: Closing Pulse Valve (150)
  8: Opening Pulse Valve (100)
  9: Closing Pulse Valve (100)

*/
