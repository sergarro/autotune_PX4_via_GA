# autotune_PX4_via_GA

The PX4_Simulink codes allow for the simulation of a fixed-wing UAV controller's actions. For this section, the definition of the waypoints' positions (latitude, longitude, altitude) and speeds in the PX4_var_controllers file is required. The results are obtained in various .mat files that are plotted using the plots code; this file compares the results of the Simulink model with the results of the PX4 autopilot code.


The autotuning codes allow for obtaining the control parameters of the attitude module through global optimization with genetic algorithms. The variables for the user to input include the values that define the reference signals to be followed (roll angle, pitch angle, and speed) and the characteristics of the genetic algorithm for each tuning phase (number of individuals and number of populations). After the simulation, the results are plotted automatically. The same procedure is followed in both the base code and the graphical interface.
