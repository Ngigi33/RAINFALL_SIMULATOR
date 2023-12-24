

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("S");   // send a capital S
    //delay(300);
  }
}
//***********************************
String create_package() {
  // # pulses , filtered pulses, Exponential L/Hr, Valve Position  
  return (String(int(litre_hr)) +delimiter +String(int(litre_hrFiltered)) + delimiter + String(int(flow_conversion_exponent(litre_hrFiltered))) + delimiter + String(int(pwm)));
  //return (String(int(litre_hrFiltered))+delimiter+String(flow_conversion_exponent(litre_hrFiltered))+delimiter+String(flow_conversion_linear(litre_hrFiltered)));// + delimiter + String(int(potFiltered)));
}
//***********************************
String create_package_calibration() {
  return ("#" + String(litre_hr)) + delimiter + String(int(potFiltered)); //+delimiter+String(valvePosition));
}

void serial_transmit_packet_calibration() {
  Serial.println(create_package_calibration());
}
void serial_transmit_packet() {
  Serial.println(create_package());
}
