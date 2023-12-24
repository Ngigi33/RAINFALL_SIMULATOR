//#include <SimpleKalmanFilter.h>

/*************************************************/
/*
   Test code for Flow sensor reading
*/
/*************************************************/
// System Flags
bool waitFlag = true;
bool streamFlag = false;
String serialBuffer[] = {"0","0"};
String val; 
float intBuffer = 0;


unsigned int menuChoice = 0;
/*************************************************/
const int FLOWSENSORPIN = 3;
unsigned int pulses;
unsigned long Currenttime;
unsigned long Looptime;
int litre_hr;
float calibrated_flowrate;
String input = "";
float setflowrate;
/*************************************************/
// Motor pins definitions
const int IN1 = 7;
const int IN2 = 8;
const int ENA = 6;
//int ValveAnglePin = 4;
int Valve_Pwm = 0;
/*************************************************/
String delimiter = ",";
/*************************************************/
// Potentiometer definitions
const int POTPIN = 4;
const int POTMAX = 95;
const int POTMIN = 70;
float potReading1 = 0;
float potReading2 = 0;
float final_pot;
int j;
const int reading;
bool slight_flag;
bool stop;
int pwm;


float valve_setpoint = 70;

#define CW 0
#define CCW 1
//____________________
// Potentiometer Mapping and Filterning
float potMapped = 0;
float potFiltered = 0;
float prevGain = 0.925;
float currentGain = 1 - prevGain;
float bias = 0.65;
//____________________
// Flowrate Filterning

float litre_hrFiltered = 0;
float prevFlowGain = 0.925;
float currentFlowGain = 1 - prevFlowGain;
float testflowgain = 0.1;
float biasFlow = 0.65;
float Previous_FRate;
//____________________

const int OPENED = 3;
const int CLOSED = 4;
const int Active_OPENING = 5;
const int Active_CLOSING = 6;
const int STOPPED = 7;
int valveStatus = STOPPED;

//____________Automode Variables___________________
int valveMode = 0;  //true for automode false for manual mode
const int MANUAL = 1;
const int AUTOMATIC = 2; 
const int STARTPID = 3;
const int STOPPID = 0;




int cast;
//SimpleKalmanFilter kf = SimpleKalmanFilter(4, 3, 0.05);

/*************************************************/
/*-----------------------------------*/

void read_pot();
void valve_init();
void process_user_input();
void pulse_valve(boolean dir, int PWM);
void stop_valve();
void establishContact();
void get_user_input();
void open_valve();
void close_valve();


void setup() {
  // put your setup code here, to run once:
  valve_init();
  flowSensor_init();
  Serial.begin(500000);
  establishContact();
  valveMode = 0;
  //Serial.println("*******: ARDUINO ONLINE");
}

/*-----------------------------------*/
void loop() {
  if (waitFlag) {
    //print_welcome();
    waitFlag = false;
  }
  get_user_input();
  process_user_input();
  read_flowRate();
  read_pot();

  if (valveMode == STARTPID) {
    process_desired_flow(cast);
  }

  serial_transmit_packet();
  //  Serial.println(String(Valve_Angle()));//Send Flowrate
  // }
  // Serial.flush();
}
/*-----------------------------------*/
