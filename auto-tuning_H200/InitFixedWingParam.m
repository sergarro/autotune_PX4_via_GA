% Fixed wing parameters
% SI units unless specified otherwise

%   Copyright 2022 The MathWorks, Inc.
uavData = struct;

%% Geometry Parameters %%

uavData.geometry        = struct;
uavData.geometry.bw     = 2.95;
uavData.geometry.cw     = 0.3731;
uavData.geometry.Sw     = 1.0162;
uavData.geometry.m      = 15;
uavData.geometry.LElev  = 1.1;
uavData.geometry.LProp  = 0;

%% Inertia Parameters %%
uavData.inertia     = struct;
uavData.inertia.Ixx = 1.609;
uavData.inertia.Iyy = 2.773;
uavData.inertia.Izz = 4.310;
uavData.inertia.Ixy = 0;
uavData.inertia.Ixz = 0;
uavData.inertia.Iyz = 0;

% REVIEW Changed the values to match the ones in TFM Joan
% uavData.inertia.Ixx = 1.6074;
% uavData.inertia.Iyy = 3.1849;
% uavData.inertia.Izz = 4.7137;
% uavData.inertia.Ixz = 0;

%% Aerodynamics Parameters %%
uavData.aero             = struct;

% CD
uavData.aero.CD0         =   0.039;
uavData.aero.A1          =   0.007;
uavData.aero.Apolar      =   0.057;

% CY
uavData.aero.CYalpha     =   0.000222;
uavData.aero.CYalpha_dot =   0.0;
uavData.aero.CYbeta      = - 0.206777;
uavData.aero.CYbeta_dot  =   0.0;
uavData.aero.CYp         =   0.016541;
uavData.aero.CYq         =   0.000186;
uavData.aero.CYr         =   0.126227;
uavData.aero.CYdeltaF    =   0.0;
uavData.aero.CYdeltaA    = - 0.000410;
uavData.aero.CYdeltaE    =   0.0;
uavData.aero.CYdeltaR    = - 0.003172; % Old value: 0.18088

% CL
uavData.aero.CL0         =   0.308;
uavData.aero.CLalpha     =   5.140879;
uavData.aero.CLalpha_dot =   0.667;
uavData.aero.CLbeta      = - 0.000028;
uavData.aero.CLbeta_dot  =   0.0;
uavData.aero.CLp         = - 0.014030;
uavData.aero.CLq         =   7.326102;
uavData.aero.CLr         = - 0.000313;
uavData.aero.CLdeltaF    =   0.013771;
uavData.aero.CLdeltaA    =   0.0;
uavData.aero.CLdeltaE    =   0.007585;
uavData.aero.CLdeltaR    =   0.0;

% Cl
uavData.aero.Clalpha     =   0.006995;
uavData.aero.Clalpha_dot =   0.0;
uavData.aero.Clbeta      = - 0.105871;
uavData.aero.Clbeta_dot  =   0.0;
uavData.aero.Clp         = - 0.476318;
uavData.aero.Clq         =   0.009900;
uavData.aero.Clr         =   0.149439;
uavData.aero.CldeltaF    =   0.000018;
uavData.aero.CldeltaA    = - 0.003786; % Old value: 0.21749
uavData.aero.CldeltaE    =   0.000010;
uavData.aero.CldeltaR    = - 0.000452; % Old value: 0.02618;

% Cm
uavData.aero.Cm0         =   0.00835;
uavData.aero.Cmalpha     = - 0.507412;
uavData.aero.Cmalpha_dot = - 2.1287;
uavData.aero.Cmbeta      =   0.000010;
uavData.aero.Cmbeta_dot  =   0.0;
uavData.aero.Cmp         =   0.001422;
uavData.aero.Cmq         = - 7.275333;
uavData.aero.Cmr         =   0.000777;
uavData.aero.CmdeltaF    = - 0.001192;
uavData.aero.CmdeltaA    =   0.0;
uavData.aero.CmdeltaE    = - 0.018500;
uavData.aero.CmdeltaR    =   0.0;

% Cn
uavData.aero.Cnalpha     =   0.000041;
uavData.aero.Cnalpha_dot =   0.0;
uavData.aero.Cnbeta      =   0.031839;
uavData.aero.Cnbeta_dot  =   0.0;
uavData.aero.Cnp         = - 0.046901;
uavData.aero.Cnq         = - 0.000371;
uavData.aero.Cnr         = - 0.041240 * 1.5; % Multiplied by 1.5 to take into account viscous effects
uavData.aero.CndeltaF    =   0.0;
uavData.aero.CndeltaA    = - 0.000072;
uavData.aero.CndeltaE    =   0.0;
uavData.aero.CndeltaR    =   0.001064; % Old value: - 0.0627

%% Engine Parameters %%
uavData.engine               = struct;
uavData.engine.NMotors       = 4;
uavData.engine.bladeDiameter = 0.3302;
uavData.engine.MinThK        = 0.077;
uavData.engine.ThK           = 2.17;
uavData.engine.TFact         = 0.2;
uavData.engine.minThrust     = 0;
uavData.engine.maxThrust     = inf;
uavData.engine.minPower      = 0;
uavData.engine.maxPower      = inf;

uavData.engine.propellerModel              = struct;
uavData.engine.propellerModel.RPMModel     = struct;
uavData.engine.propellerModel.RPMModel.pn1 = 179.9970;
uavData.engine.propellerModel.CTModel      = struct;
uavData.engine.propellerModel.CTModel.pCT3 =   0.07115;
uavData.engine.propellerModel.CTModel.pCT2 = - 0.1954;
uavData.engine.propellerModel.CTModel.pCT1 = - 0.02019;
uavData.engine.propellerModel.CTModel.pCT0 =   0.1068;
uavData.engine.propellerModel.CPModel      = struct;
uavData.engine.propellerModel.CPModel.pCP6 =   0.1446;
uavData.engine.propellerModel.CPModel.pCP5 =   0.0126;
uavData.engine.propellerModel.CPModel.pCP4 = - 0.4078;
uavData.engine.propellerModel.CPModel.pCP3 =   0.2859;
uavData.engine.propellerModel.CPModel.pCP2 = - 0.1337;
uavData.engine.propellerModel.CPModel.pCP1 =   0.0424;
uavData.engine.propellerModel.CPModel.pCP0 =   0.03482;


%% Initial Parameters %%
uavData.ic         = struct;
uavData.ic.Pos_0   = [0; 0; 50];
uavData.ic.Euler_0 = [0; 0; 1.5707963267948966];
uavData.ic.Omega_0 = [0; 0; 0];
uavData.ic.PQR_0   = [0; 0; 0];
uavData.ic.Vb_0    = [18; 0; 0];
uavData.ic.gsLL    = [42.2996388 -71.3517757];
uavData.ic.gsH     = 150;

%% Control Actuators Parameters %%
uavData.cntrl               = struct;
uavData.cntrl.naturalFreq   = 35;
uavData.cntrl.dampingRatio  = 0.75;
uavData.cntrl.initPos       = 0;
uavData.cntrl.initVel       = 0;

uavData.cntrl.flapsGain     =   1;
uavData.cntrl.aileronGain   =   - 30; % Multiplied by -1 
uavData.cntrl.elevatorGain  =   - cos(deg2rad(36))*15;
uavData.cntrl.rudderGain    =   sin(deg2rad(36))*15; % Multiplied by -1
uavData.cntrl.throttleGain  =   1;

uavData.cntrl.minElevatorDef = - 1;
uavData.cntrl.maxElevatorDef =   1;
uavData.cntrl.minAileronDef  = - 1;
uavData.cntrl.maxAileronDef  =   1;
uavData.cntrl.minRudderDef   = - 1;
uavData.cntrl.maxRudderDef   =   1;
uavData.cntrl.minFlapsDef    = - 1;
uavData.cntrl.maxFlapsDef    =   1;
uavData.cntrl.minThrottle    =   0;
uavData.cntrl.maxThrottle    =   1;

%% Contact Parameters %%
uavData.contact                 = struct;
uavData.contact.naturalFreq     = 20;
uavData.contact.spring          = uavData.geometry.m * (uavData.contact.naturalFreq * 2 * pi)^2;
uavData.contact.damper          = 2 * uavData.geometry.m * sqrt(uavData.contact.spring / uavData.geometry.m);
uavData.contact.rollingFriction = 0.2;
uavData.contact.vd              = 0.02;
uavData.contact.slidingFriction = 0.8;
uavData.contact.gLimit          = 100;

% LocalWords:  uav
