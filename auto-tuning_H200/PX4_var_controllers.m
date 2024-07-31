% Waypoints
    %Home 
    home_lat = 39.49738807491014;
    home_lon =  -0.6268122488722822;
    home_alt = 171;
    home = [home_lat,home_lon,home_alt];

transitionRadius = 120; 
assignin("base","transitionRadius",transitionRadius)
orbitRadius = 20;
turnDir = -1;
numTurns = 1;



% Vuelo cambio altitud y velocidad

nwap = 9;
assignin("base","nwap",nwap)
V_cruise = [15,15,15,20,25,25,20,15,15];
assignin("base","V_cruise",V_cruise)

poswp1 = lla2ned([39.49738807491014,-0.6268122488722822,home_alt+25],[home_lat,home_lon,home_alt],'flat');
wp(1) = struct(mode=uint8(2), position=poswp1', params=[0, transitionRadius,0 ,0]');

poswp2 = lla2ned([39.4992227,-0.6238685,home_alt+25],[home_lat,home_lon,home_alt],'flat');
wp(2) = struct(mode=uint8(2), position=poswp2', params=[0, transitionRadius,0 ,0]');

poswp3 = lla2ned([39.4977478, -0.6219916,home_alt+25],[home_lat,home_lon,home_alt],'flat');
wp(3) = struct(mode=uint8(2), position=poswp3', params=[0, transitionRadius,0 ,0]');

poswp4 = lla2ned([39.4997280, -0.6185623,home_alt+37.5],[home_lat,home_lon,home_alt],'flat');
wp(4) = struct(mode=uint8(2), position=poswp4', params=[0, transitionRadius,0 ,0]');

poswp5 = lla2ned([39.5017082,-0.6151329,home_alt+50],[home_lat,home_lon,home_alt],'flat');
wp(5) = struct(mode=uint8(2), position=poswp5', params=[0, transitionRadius,0 ,0]');

poswp6 = lla2ned([39.5007038,-0.6137955,home_alt+50],[home_lat,home_lon,home_alt],'flat');
wp(6) = struct(mode=uint8(2), position=poswp6', params=[0, transitionRadius,0 ,0]');

poswp7 = lla2ned([39.4985765, -0.6172384,home_alt+37.5],[home_lat,home_lon,home_alt],'flat');
wp(7) = struct(mode=uint8(2), position=poswp7', params=[0, transitionRadius,0 ,0]');

poswp8 = lla2ned([39.4964990,-0.6206330,home_alt+25],[home_lat,home_lon,home_alt],'flat');
wp(8) = struct(mode=uint8(2), position=poswp8', params=[0, transitionRadius,0 ,0]');

poswp9 = lla2ned([39.5015308,-0.6213116,home_alt+25],[home_lat,home_lon,home_alt],'flat');
wp(9) = struct(mode=uint8(2), position=poswp9', params=[0, transitionRadius,0 ,0]');


mission = [wp];
assignin("base","mission",mission)
poswp = [poswp1;poswp2;poswp3;poswp4;poswp5;poswp6;poswp7;poswp8;poswp9];
assignin("base","poswp",poswp)

% Controller parameters
g = 9.81;
assignin("base","g",g)

frecuency = 0.012; 
assignin("base","frecuency",frecuency)

% Position control 
PC.L1 = 20;
assignin("base","PC",PC)

% Total energy 
TECS.tas_error_percetange = 0.15;
TECS.equivalent_airspeed_trim = 15;
TECS.tas_min = 10;
assignin("base","TECS",TECS)

% Total energy control loop
TECL.V_error_gain = 1/5;
TECL.h_error_gain = 1/5;
TECL.h_ff_gain = 0.3;
TECL.KI = 0.05;
TECL.KD = 0.1;
TECL.max_climb_rate = 5;
TECL.min_sink_rate = 2;
TECL.T_cruise = 0;
TECL.T_max = 1;
TECL.T_min = 0;
TECL.T_slewrate = 0;
TECL.altitude_rate_sp = 1;
TECL.load_factor_correction = 15;
TECL.descent_rate = 0;
assignin("base","TECL",TECL)

%Total energy balance control loop
TEBCL.KI = 0.1; 
TEBCL.KD = 0.1;
TEBCL.pitch_speed_weight = 1;%1 equilibrado, 0 sigue referencia altitud, 2 sigue referencia velocidad
TEBCL.rate_ff = 1; 
TEBCL.pitch_max = 30*pi/180;
TEBCL.pitch_min = -30*pi/180;
TEBCL.vert_accel_limit = 7;
pitch_integ_state = 0;
assignin("base","TEBCL",TEBCL)
assignin("base","pitch_integ_state",pitch_integ_state)

% Lateral control 
LC.L1_damping = 0.7;
LC.L1_period = 25;
LC.roll_max = 50*pi/180;
LC.roll_min = -50*pi/180;
assignin("base","LC",LC)

% Attitude control
AT.max_rate_roll = 70 *pi/180;
AT.max_rate_pitch = 60*pi/180;
AT.max_rate_yaw = 50 *pi/180;
assignin("base","AT",AT)