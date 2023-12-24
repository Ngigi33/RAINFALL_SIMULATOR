#include <PID_v1.h>

double Setpoint, Input, Output;
//PID Constants
float kp = 5;
float kd = 2;
float ki = 0;

float error = 0;
float errorMIN = 3;


PID myPID(&Input, &Output, &Setpoint, kp, ki, kd, DIRECT);


void PID_init() {
  myPID.SetMode(AUTOMATIC);
}
void process_desired_flow(int desiredFlow)
{

  read_flowRate();
  error = desiredFlow - litre_hr;
  Input = error;
  myPID.Compute();

  //  int errorSign = (Output >= 0) ? 1 : 0 ;
  //
  //  if (Output > 0)
  //  {
  //    open_valve();
  //    read_pot();
  //  }
  //  else if (Output < 0)
  //  {
  //    close_valve();
  //    read_pot();
  //  }
  //  else
  //  {
  //    stop_valve;
  //  }


  int errorSign = (error >= 0) ? 1 : 0 ;
  int errorMag = (error * error) / 2;
  if (errorMag < 3) {
    stop_valve();
  } else {
    read_pot();
    if (errorSign == true && final_pot > POTMIN ) {
      open_valve();
      delay(200);
      stop_valve();
      read_flowRate();
      //read_pot();

    } else if (errorSign == false && final_pot < POTMAX)
    {
      close_valve();
      delay(200);
      stop_valve();
      read_flowRate();
      //read_pot();
    }
    else
    {
      stop_valve;
    }
  }

}
