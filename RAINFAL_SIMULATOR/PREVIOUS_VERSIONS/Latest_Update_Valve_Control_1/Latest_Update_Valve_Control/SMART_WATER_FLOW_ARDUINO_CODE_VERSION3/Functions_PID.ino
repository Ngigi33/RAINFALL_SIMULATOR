float error = 0;
float errorMIN = 3;

void process_desired_flow(int desiredFlow) {
  read_flowRate();
  error = desiredFlow - calibrated_flowrate;
  int errorSign = (error >= 0) ? 1 : 0 ;
  int errorMag = abs(error);
  if (errorMag <2 ) {
    stop_valve();
  } else {
    // read_pot();
    if (errorSign == true && final_pot > POTMIN ) {
      open_valve();
      process_flowrate();
     
    }
    else if (errorSign == false && final_pot < POTMAX)
    {
      close_valve();
      process_flowrate();
     
    }
    else
    {
      stop_valve();
    }
  }

}
