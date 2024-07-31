% Initialize environmental constants

%   Copyright 2022 The MathWorks, Inc.

env                       = struct;
%% ISA Atmosphere Parameters
env.ISA_g                 = 9.80665;
env.ISA_ratioHeats        = 1.4;
env.ISA_R                 = 287.0531;
env.ISA_lapse             = 0.0065;
env.ISA_troposphereHeight = 11000;
env.ISA_tropopauseHeight  = 20000;
env.ISA_rho0              = 1.225;
env.ISA_P0                = 101325;
env.ISA_T0                = 288.15;
env.ISA_hmax              = 2000;
env.ISA_hmin              = 0;

%% Wind Parameters
env.windBase              = 12;
env.windDirTurb           = 180;
env.windDirHor            = 90;
env.windVector            = [0, 0, 0];
