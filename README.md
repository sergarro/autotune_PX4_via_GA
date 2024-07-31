# autotune_PX4_via_GA
**PX4_Simulink**

The PX4_Simulink codes allow for the simulation of a fixed-wing UAV controller's actions. For this section, the definition of the waypoints' positions (latitude, longitude, altitude) and speeds in the PX4_var_controllers file is required. The results are obtained in various .mat files that are plotted using the plots code; this file compares the results of the Simulink model with the results of the PX4 autopilot code.

To carry out the simulations, the following steps must be followed:
1. Define the reference trajectory and speeds in the PX4_var_controllers file.
2. Run the InitSimulinkPlantVars file, which defines all the parameters required in the Simulink diagram.
3. Execute the Simulink diagram.
4. Run the plots file to obtain graphs of the results and compare them with those of PX4.

The PX4 results are obtained by executing the code of this autopilot through software-in-the-loop, but it is possible to modify the plots file to only graph the results of the Simulink scheme.

**Autotuning**

The autotuning codes allow for obtaining the control parameters of the attitude module through global optimization with genetic algorithms. The variables for the user to input include the values that define the reference signals to be followed (roll angle, pitch angle, and speed) and the characteristics of the genetic algorithm for each tuning phase (number of individuals and number of populations). After the simulation, the results are plotted automatically. The same procedure is followed in both the base code and the graphical interface.

To carry out this tuning process, the following steps must be followed:
1. Define the reference signals to follow, change times, and amplitudes of pitch angle, roll angle, and speed in the autotuning file.
2. Define the characteristics of the genetic algorithm for each tuning phase (longitudinal tuning, lateral tuning, and global tuning) in the autotuning file. For each case, it is necessary to set the number of individuals (recommended between 150-200) and the number of iterations. A higher number of both yields better results but increases computational cost.
3. Execute the autotuning file.
4. Upon completion of each phase, the results will be displayed.

When using the graphical interface, the procedure is similar.






