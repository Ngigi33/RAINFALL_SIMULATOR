/*-----------------------------------*/
void get_user_input() {
  if (Serial.available() > 0) {
    menuChoice = Serial.parseInt();

    if (menuChoice == 0) {
      waitFlag = false ;
    } else {
      waitFlag = true;
    }
  };

  //  while (Serial.available() == 0)
  //  {
  //    input = Serial.readString();
  //  }
}
/*-----------------------------------*/
void process_user_input() {
  if ((menuChoice != 0) && (menuChoice <= 10)) {
    //Serial.println(menuChoice);
    switch (menuChoice) {
      case 1:
        // Stream Flowrate readings
        streamFlag = true;
        break;

      case 2:
        // Stop Stream Flowrate readings
        streamFlag = false;
        break;

      case 3:
        // Fully open the valve
        full_open_valve();
        Serial.println("opened");
        break;

      case 4:
        // Fully close the valve
        full_close_valve();
        Serial.println("closed");
        break;

      case 5:
        // Fully close the valve
        //calibrate_valve_flowrate();
        break;

      //      case 6:
      //        // Opening the valve
      //        pulse_valve(CCW, 150);
      //        stop_valve();
      //        break;
      //
      //      case 7:
      //        // Closing the valve
      //        pulse_valve(CW, 150);
      //        stop_valve();
      //        break;
      //
      //      case 8:
      //        // Opening the valve
      //        pulse_valve(CCW, 100);
      //        stop_valve();
      //        break;
      //
      //      case 9:
      //        // Closing the valve
      //        pulse_valve(CW, 100);
      //        stop_valve();
      //        break;

      case 6:
        b = true;
        slight_open_valve();
        break;

      case 7:
        b = true;
        slight_close_valve();
        break;

      case 8:
        Serial.println("8");
        read_pot();
        serial_transmit_packet();
        stop_valve();

      case 9:
        Serial.println("A");
        //delay(200);
        //Serial.println("HELLO.......");
        mode=true;
      //        read_pot();
      //        serial_transmit_packet();


      default:
        streamFlag = streamFlag;
        //Serial.println("S");

    }
  } else if ((menuChoice != 0 ) && (menuChoice > 10)&& (mode)) {
    int cast = int(menuChoice) - 10;
    process_desired_flow(cast);
  }
  Serial.print("RECEIVED INPUT:");
  Serial.println(menuChoice);
  //  if (input = !0)
  //  {
  //    Serial.print("RECEIVED INPUT:");
  //    Serial.println(input);
  //  }
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
