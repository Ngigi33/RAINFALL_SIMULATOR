void valve_init() {
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);
  pinMode(POTPIN, INPUT);
}
/*-----------------------------------*/
void read_pot() {
  //potReading = analogRead(POTPIN);
  //potReading=pulseIn(POTPIN, HIGH);
  potReading1 = pulseIn(POTPIN, HIGH);
  potReading2 = pulseIn(POTPIN, LOW);
  final_pot = float((potReading1) / (potReading1 + potReading2)) * 100;
  pwm = map(int(final_pot), 70, 95, 0, 100);
  if (pwm < 0) { pwm = 0; }
  if (pwm > 100) { pwm = 100; }
}
/*-----------------------------------*/
void pot_processing() {
  potReading1 = analogRead(POTPIN);
  potMapped = map(potReading1, 0, 1023, 100, 0);
  potFiltered = floor(potFiltered) * prevGain + potMapped * currentGain;
  potFiltered += bias;
}
/*------------------------------------*/

void open_valve() {
  // valve_control(100);
  analogWrite(ENA, 210);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  delay(150);
  stop_valve();
}

/*------------------------------------*/
void close_valve2() {
  //valve_control(0);
  analogWrite(ENA, 210);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
}

void open_valve2() {
  analogWrite(ENA, 210);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
}

/*------------------------------------*/
void close_valve() {
  //valve_control(0);
  analogWrite(ENA, 210);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  delay(150);
  stop_valve();
}
/*------------------------------------*/
void stop_valve() {
  analogWrite(ENA, 0);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
}
/*------------------------------------*/
void full_close_valve() {
  valveStatus = Active_CLOSING;
  while (final_pot < POTMAX) {
    read_pot();
    serial_transmit_packet();
    close_valve2();
    if (stop) {
      break;
    }
  }
  stop = false;
  stop_valve();
  valveStatus = CLOSED;
}
/*------------------------------------*/
void full_open_valve() {
  valveStatus = Active_OPENING;
  while (final_pot > POTMIN) {
    read_pot();
    serial_transmit_packet();
    open_valve2();
    if (stop) {
      break;
    }
  }
  stop = false;
  stop_valve();
  valveStatus = OPENED;
}
/*------------------------------------*/
void slight_close_valve() {
  if (slight_flag /*&& final_pot < POTMAX*/) {
    close_valve2();
    Serial.println("SLIGHTLY_CLOSE");
    delay(200);
    stop_valve();
  }
  valveStatus = Active_CLOSING;
  serial_transmit_packet();
  slight_flag = false;
}
/*------------------------------------*/
void slight_open_valve() {
  if (slight_flag /*&& final_pot > POTMIN*/) {
    open_valve2();
    Serial.println("SLIGHTLY_OPEN");
    delay(200);
    stop_valve();
  }
  valveStatus = Active_OPENING;
  serial_transmit_packet();
  slight_flag = false;
}
/*------------------------------------*/
/*------------------------------------*/
//void slight_open_valve() {
// read_pot();
// serial_transmit_packet();
// if (slight_flag) {
//read_pot();
//   open_valve2();
//   delay(500);
//   serial_transmit_packet();
//   Serial.println("OPENING %");
//   slight_flag=false;
// }
// stop_valve();
// valvePosition = CLOSED;
// Serial.println(valvePosition);
//}
/*------------------------------------*/




void test_open_valve() {
  while (potFiltered >= POTMIN) {
    open_valve();
    pot_processing();
  }
  stop_valve();
  valveStatus = OPENED;
}
/*------------------------------------*/

void pulse_valve(boolean dir, int PWM) {
  if (dir == CW) {
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
  } else if (dir == CCW) {
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
  }
  digitalWrite(ENA, PWM);
  delay(200);
}
/*------------------------------------*/
void valve_control(float current, float setpoint) {
  float error = setpoint - current;
  boolean valve_dir = (error > 0) ? CW : CCW;
  float mag = sqrt(error * error);
  if (mag >= 1) {
    pulse_valve(valve_dir, 150);
  } else {
    stop_valve();
  }
}
