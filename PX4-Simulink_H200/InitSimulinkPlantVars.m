% Plant constants

%   Copyright 2022 The MathWorks, Inc.

InitFixedWingParam; % Load H200 UAV data
InitEnvironment;    % Load environment data
PX4_var_controllers;

% Reference location: Aeroclub RC Valencia (Cheste) 39.49738807491014, -0.6268122488722822, 171m altura
% Reference location: Aeroclub Ala RC (Lliria) 39.678999 , -0.608276, 226m altura
% This is the home position also , 
% ref_lat    =  39.678421; 
% ref_lon    = -0.606184;
% ref_height = 224.0;
ref_lat    =  39.49738807491014; 
ref_lon    = -0.6268122488722822;
ref_height = 171;

% Flight Conditions CdV = [z (m), V (m/s)]
CdV = [25 + ref_height, 15];

% Initial states
init.posNED   = [0, 0, - (CdV(1) - ref_height)]'; % Initial NED position in flat Earth frame (Xe, Ye, Ze)  [m,     m,     m    ]

if init.posNED(3) > 0
   init.posNED(3) = - init.posNED(3);
end

init.vb       = [CdV(2), 0, 0]';                  % Initial body linear velocities (u, v, w)               [m/s,   m/s,   m/s  ]
% init.posNED = [0, 0, 0]; % m
% init.vb = [0 0 0]'; %m/s
% init.euler    = [0, 0, deg2rad(290)]';                  % Initial Euler orientation (Roll, Pitch, Yaw)           [rad,   rad,   rad  ]
init.euler    = [0, 0, pi/3.5]';                  % Initial Euler orientation (Roll, Pitch, Yaw)           [rad,   rad,   rad  ] RC Valencia Cheste
init.angRates = [0, 0, 0]';                       % Initial body rotation rates (p, q, r)                  [rad/s, rad/s, rad/s]

% Simulation Time
Tsim = 10;
Ts   = 0.01;

%% UAV Dynamics Data Serialization Constants

% Gain to convert m to mm
m_to_mm = 1000;

% Gain to convert uT to Gauss
uT_to_gauss = 0.01;

% Gain to convert m/s^2 to mg
ms2_to_mg = (1/env.ISA_g)*1000;

% Gain to convert m/s to cm/s
ms_to_cms = 100;

% Maximum Serial data read size from Pixhawk
MAVLink_Input_Read_Size = 1024;
