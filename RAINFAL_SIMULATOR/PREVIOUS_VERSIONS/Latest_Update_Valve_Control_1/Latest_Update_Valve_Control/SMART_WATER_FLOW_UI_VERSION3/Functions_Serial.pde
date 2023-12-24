void serialEvent(Serial myPort) {
  //put the incoming data into a String
  val = myPort.readStringUntil('\n');

  //make sure our data isn't empty before continuing
  if (val != null) {
    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);

    //look for our 'S' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) {
      if (val.equals("S")) {
        myPort.clear();
        firstContact = true;
        myPort.write("H");
        println("contact");
        customize_connect_button(connectSerial);
        valveStatus = "ACTIVE";
      }
    } else {

      //if we've already established contact, keep getting and parsing data
      //println(val);
      process_serial();
      print("Incoming:");
      println(process_serial());
      flowRate = float(val);
    }
  }
}

String[] process_serial() {
  String[] parsedData = split(val, ',');
  if (parsedData[0].equals("[") == true) {
    for (int i = 0; i < parsedData.length && i < 4; i++) {
      serialBuffer[i] = parsedData[i+1];
    }
  } else if (parsedData[0].equals("V") == true) {
    
  }
  return parsedData;
}

void serial_readString(Serial port) {
  if (port.available() > 0)
  {  // If data is available,
    val = port.readStringUntil('\n');         // read it and store it in val
  }
  if (val != null) {
    println(val); //print it out in the console
  }
}

void serial_readBytes() {
  // get the byte:
  int inByte = myPort.read();
  // print it:
  println(inByte);
}


/*
H => Handshaking (Processing)
 S => Handshaking (Arduino)
 C => Commands
 D => Desired Flowrate
 F => Flowrate
 P => Pot position
 */
