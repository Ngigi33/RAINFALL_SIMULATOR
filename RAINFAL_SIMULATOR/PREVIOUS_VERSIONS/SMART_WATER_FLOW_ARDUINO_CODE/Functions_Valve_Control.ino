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
  if(pwm>100){pwm=100;}
   if(pwm<0){pwm = 0;}
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
  valveStatus = OPENING;
  analogWrite(ENA, 150);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, HIGH);
  delay(500);
  //stop_valve();
}

/*------------------------------------*/
void close_valve() {
  valveStatus = CLOSING;
  analogWrite(ENA, 150);
  digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);
  delay(500);
  //stop_valve();
}

/*------------------------------------*/
void stop_valve() {
  valveStatus = STOPPED;
  analogWrite(ENA, 0);
  digitalWrite(IN1, LOW);
  digitalWrite(IN2, LOW);
}
/*------------------------------------*/
void full_close_valve() {
  read_pot();
  serial_transmit_packet();
  while (final_pot < POTMAX) {
    read_pot();
    // delay(500);
    close_valve();
    serial_transmit_packet();
    Serial.println("CLOSING");
  }
  stop_valve();
  valvePosition = CLOSED;
  Serial.println(valvePosition);
}
/*------------------------------------*/
void full_open_valve() {
  read_pot();
  serial_transmit_packet();
  while (final_pot > POTMIN) {
    read_pot();
    //delay(500);
    open_valve();
    serial_transmit_packet();
    Serial.println("OPENING");
  }
  stop_valve();
  valvePosition = OPENED;
  Serial.println(valvePosition);
}
/*------------------------------------*/
void slight_close_valve() {
  read_pot();
  serial_transmit_packet();
  if (b) {
    read_pot();
    close_valve();
    delay(500);
    serial_transmit_packet();
    Serial.println("CLOSING %");
    b=false;
  }
  stop_valve();
  valvePosition = CLOSED;
  Serial.println(valvePosition);
}
/*------------------------------------*/
void slight_open_valve() {
  read_pot();
  serial_transmit_packet();
  if (b) {
    read_pot();
    open_valve();
    delay(500);
    serial_transmit_packet();
    Serial.println("OPENING %");
    b=false;
  }
  stop_valve();
  valvePosition = CLOSED;
  Serial.println(valvePosition);
}
/*------------------------------------*/
void test_open_valve() {
  while (potFiltered >= POTMIN) {
    open_valve();
    pot_processing();
  }
  stop_valve();
  valvePosition = OPENED;
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
  }
  else {
    stop_valve();
  }
}
