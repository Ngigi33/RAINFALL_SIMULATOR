//void calibrate_valve_flowrate() {
//  Serial.println("CALIBRATING");
//  int count = 1;
//  while (litre_hr >= 14) {
//    pulse_valve(CW, 150);
//    stop_valve();
//    for (int i = 0; i < 60; i++) {
//      read_flowRate();
//      pot_processing();
//      delay(100);
//    }
//    Serial.println(String(count) + delimiter + String(litre_hr) + delimiter + String(int(potFiltered)));
//    count++;
//  }
//  Serial.println("CALIBRATION DONE");
//}
