%% Código auto-tuning 
% En este código se realiza una implementación de un sistema de auto-tuning
% para parámetros de control de un auto-piloto PX4.

timestop = 65;      % Define el tiempo final de la simulación
%% Ajuste dinámica longitudinal 
    % Se desactivan las fuerzas laterales del modelo, un valor de 1 indica
    % que se activan y un valor de 0 que se desactivan.
    F_lon = 1;
    F_lat = 0;

    % Define referencia a seguir
        nav = 0;        % Si nav = 0 se desactiva el control de posición, si nav = 0 se activa el control de posición

    % Pitch ref: se establece como una entrada escalón
tiempo_pitch = [0, 1, 1, 10, 10, 20, 20, 30, 30, 40, 40, 50, 50, 60];               % Tiempos de cambio de referencia
amplitud_pitch = deg2rad([0, 0, 5, 5, 0, 0, -2.5, -2.5, 0, 0, 10, 10, 0, 0]);       % Amplitudes correspondientes de ángulo de cabeceo en grados
pitch_sp =timeseries(amplitud_pitch,tiempo_pitch);

    % Roll ref: se establece como un valor constante y 0 para el caso
    % longitudinal
tiempo_roll = [0];                                      % Tiempos de cambio
amplitud_roll= deg2rad([0]);                            % Amplitudes correspondientes de ángulo de alabeo en grados
roll_sp = timeseries(amplitud_roll,tiempo_roll);

    % Velocidad ref: se establece como una entrada escalón
tiempo_vel = [0, 10, 10, 20, 20, 30, 30, 40];           % Tiempos de cambio de referencia
amplitud_vel= [15, 15, 20, 20, 25, 25, 15, 15];         % Amplitudes correspondientes de velocidad en m/s
velocidad_sp = timeseries(amplitud_vel,tiempo_vel);

    % Throttle ref: se establece como un valor constante ya que este es
    % calculado por el control de posición.
throttle_sp = 0.6;

% Sistema simulado 
    % Controles laterales: se establecen a un valor inicial de 0
    roll_P = 0;
    roll_I= 0;
    roll_D = 0;
    tc_roll = 1;
    roll_ff = 0;
    yaw_P = 0;
    yaw_I = 0;
    yaw_D = 0;
    yaw_ff = 0;

    % Controles longitudinales 
    clear ("pitch_P","pitch_I","pitch_D","tc_pitch","pitch_ff");
    lb_pitch = [0 0 0 0.2 0];       % Límite inferior de los parámetros de control longitudinales
    ub_pitch = [10 10 10 1 10];     % Límite superior de los parámetros de control longitudinales 
    
    % Algoritmo genético
    InitSimulinkPlantVars      %Inicializa los parámetros del modelo de Simulink
    gaDat.Objfun = 'Error_Medio_Cuadratico_lon';       % Función objetivo dinámica longitudinal
    lb = lb_pitch;
    ub = ub_pitch;
    gaDat.FieldD = [lb; ub];
    gaDat.indini = [];
    gaDat.MAXGEN = 50;    % Máximo número de iteraciones 
    gaDat.NIND = 175;     % Número de individuos por población, su valor estandar entre 150-200
    gaDat = ga(gaDat);
    gaDat.xmin;  
    gaDat.fxmin;
   
    % Representación controles y errores
figure('Name','Control Pitch')
subplot(3,2,1)
plot(gaDat.xmingen(:,1))
grid on
title 'Pitch\_P'
xlabel 'Iteraciones'

subplot(3,2,3)
plot(gaDat.xmingen(:,2))
grid on
title 'Pitch\_I'
xlabel 'Iteraciones'

subplot(3,2,5)
plot(gaDat.xmingen(:,3))
grid on
title 'Pitch\_D'
xlabel 'Iteraciones'

subplot(3,2,2)
plot(gaDat.xmingen(:,4))
grid on
title 'tc\_pitch'
xlabel 'Iteraciones'

subplot(3,2,4)
plot(gaDat.xmingen(:,5))
grid on
title 'Pitch\_ff'
xlabel 'Iteraciones'

figure('Name','Error longitudinal')
plot(gaDat.fxmingen(:,1))
grid on
title 'Error\_long'
xlabel 'Iteraciones'

% Representación ángulo y rates
pitch_P = gaDat.xmin(1);
pitch_I = gaDat.xmin(2);
pitch_D = gaDat.xmin(3);
tc_pitch = gaDat.xmin(4);
pitch_ff = gaDat.xmin(5);
sim('FixedWing_Dynamic_Model_SIL_simulink');
Simulink_pitch_sp = load('simulacionSimulink_pitch_sp');
Simulink_RPY = load('simulacionSimulink_RPY');
Simulink_rates_sp = load('simulacionSimulink_ratesRPY_sp');
Simulink_rates = load('simulacionSimulink_ratesRPY');

figure('Name','Ángulo y rate pitch')
subplot(2,1,1)
plot(Simulink_pitch_sp.ans.Time,Simulink_pitch_sp.ans.Data(:)*180/pi,Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,2)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Pitch [deg]'
title 'Ángulo cabeceo'
legend('ref','est')

subplot(2,1,2)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,2)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,2)*180/pi)
grid on
ylabel 'Pitch rate [deg/s]'
xlabel 'Tiempo [s]'
title 'Velocidad cabeceo'
legend('ref','est')
%% Ajuste dinámica lateral
% Se activan las fuerzas laterales del modelo, un valor de 1 indica
% que se activan y un valor de 0 que se desactivan.
 F_lon = 1;
 F_lat = 1;

 % Define referencia a seguir

nav = 0; % Si nav = 0 se desactiva el control de posición, si nav = 0 se activa el control de posición

    % Pitch ref: se establece como un valor constante y 0 para el caso
    % lateral
tiempo_pitch = [0];                                     % Tiempos de cambio de referencia 
amplitud_pitch = deg2rad([0]);                          % Amplitudes correspondientes de ángulo de cabeceo en grados 
pitch_sp =timeseries(amplitud_pitch,tiempo_pitch);

    % Roll ref: se establece como una entrada escalón 
tiempo_roll = [0, 1, 1, 3, 3, 5, 5, 7, 7, 9, 9, 15, 15, 20, 20, 25, 25, 35, 35, 45, 45, 55, 55, 60, 60, 65];                % Tiempos de cambio de referencia
amplitud_roll= deg2rad([0, 0, 5, 5, 0, 0, -5, -5, 0, 0, 10, 10, 0, 0, -10, -10, 0, 0, 20, 20, 0, 0, -20 ,-20, 0, 0]);       % Amplitudes correspondientes de ángulo de alabeo en grados
roll_sp = timeseries(amplitud_roll,tiempo_roll);

    % Velocidad ref: se establece constante
tiempo_vel = [0];                                       % Tiempos de cambio de referencia 
amplitud_vel= [15];                                     % Amplitudes correspondientes de velocidad en m/s
velocidad_sp = timeseries(amplitud_vel,tiempo_vel);

    % Throttle ref: se establece como un valor constante ya que este es
    % calculado por el control de posición.
throttle_sp = 0.6;

% Sistema simulado 
    % Control longitudinal: valores de ajuste longitudinal 
    pitch_P = gaDat.xmin(1);
    pitch_I = gaDat.xmin(2);
    pitch_D = gaDat.xmin(3);
    pitch_tc = gaDat.xmin(4);
    pitch_ff = gaDat.xmin(5);

    % Controles laterales
clear("roll_P","roll_I","roll_D","tc_roll","roll_ff","yaw_P","yaw_I","yaw_D","yaw_ff");
    lb_roll = [0 0 0 0.2 0];            % Límite inferior de los parámetros de control laterales (alabeo)
    ub_roll = [10 10 10 1 10];          % Límite superior de los parámetros de control laterales (alabeo)
    lb_yaw = [0 0 0 0];                 % Límite inferior de los parámetros de control laterales (guiñada)
    ub_yaw = [10 10 10 10];             % Límite superior de los parámetros de control laterales (guiñada)

     % Algoritmo genético
    InitSimulinkPlantVars      %Inicializa los parámetros del modelo de Simulink
    gaDat2.Objfun = 'Error_Medio_Cuadratico_lat';       % Función objetivo dinámica lateral
    lb2 = [lb_roll,lb_yaw];
    ub2 = [ub_roll,ub_yaw];
    gaDat2.FieldD = [lb2; ub2];
    gaDat2.indini = [];
    gaDat2.MAXGEN = 50;    % Máximo número de iteraciones  
    gaDat2.NIND = 175;     % Número de individuos por población, su valor estandar entre 150-200
    gaDat2 = ga(gaDat2);
    gaDat2.xmin;  
    gaDat2.fxmin;

 % Representación control y error
figure('Name','Control roll')
subplot(3,2,1)
plot(gaDat2.xmingen(:,1))
grid on
title 'Roll\_P'
xlabel 'Iteraciones'

subplot(3,2,3)
plot(gaDat2.xmingen(:,2))
grid on
title 'Roll\_I'
xlabel 'Iteraciones'

subplot(3,2,5)
plot(gaDat2.xmingen(:,3))
grid on
title 'Roll\_D'
xlabel 'Iteraciones'

subplot(3,2,2)
plot(gaDat2.xmingen(:,4))
grid on
title 'tc\_roll'
xlabel 'Iteraciones'

subplot(3,2,4)
plot(gaDat2.xmingen(:,5))
grid on
title 'Roll\_ff'
xlabel 'Iteraciones'

figure('Name','Control yaw')
subplot(2,2,1)
plot(gaDat2.xmingen(:,6))
grid on
title 'Yaw\_P'
xlabel 'Iteraciones'

subplot(2,2,3)
plot(gaDat2.xmingen(:,7))
grid on
title 'Yaw\_I'
xlabel 'Iteraciones'

subplot(2,2,2)
plot(gaDat2.xmingen(:,8))
grid on
title 'Yaw\_D'
xlabel 'Iteraciones'

subplot(2,2,4)
plot(gaDat2.xmingen(:,9))
grid on
title 'Yaw\_ff'
xlabel 'Iteraciones'

figure('Name','Error lateral')
plot(gaDat2.fxmingen(:,1))
grid on
title 'Error lateral'
xlabel 'Iteraciones'

% Representación ángulo y rates
roll_P = gaDat2.xmin(1);
roll_I = gaDat2.xmin(2);
roll_D = gaDat2.xmin(3);
tc_roll = gaDat2.xmin(4);
roll_ff = gaDat2.xmin(5);
yaw_P = gaDat2.xmin(6);
yaw_I = gaDat2.xmin(7);
yaw_D = gaDat2.xmin(8);
yaw_ff = gaDat2.xmin(9);
sim('FixedWing_Dynamic_Model_SIL_simulink');
Simulink_roll_sp = load('simulacionSimulink_roll_sp');
Simulink_RPY = load('simulacionSimulink_RPY');
Simulink_rates_sp = load('simulacionSimulink_ratesRPY_sp');
Simulink_rates = load('simulacionSimulink_ratesRPY');

figure('Name','Ángulo y rate roll y yaw')
subplot(4,1,1)
plot(Simulink_roll_sp.ans.Time,Simulink_roll_sp.ans.Data(:)*180/pi,Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,1)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Roll [deg]'
title 'Ángulo alabeo'
legend('ref','est')

subplot(4,1,2)
plot(Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,3)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Yaw [deg]'
title 'Ángulo guiñada'
legend('est')

subplot(4,1,3)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,1)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,1)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Roll rate [deg/s]'
title 'Velocidad alabeo'
legend('ref','est')

subplot(4,1,4)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,3)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,3)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Yaw rate [deg/s]'
title 'Velocidad de guiñada'
legend('ref','est')
    %% Ajuste total del sistema
% Se activan las fuerzas laterales y longitudinales del modelo, un valor de 1 indica
% que se activan y un valor de 0 que se desactivan.
 F_lon = 1;
 F_lat = 1;

 % Define referencia a seguir

nav = 0; % Si nav = 0 se desactiva el control de posición, si nav = 0 se activa el control de posición

    % Pitch ref: se establece como una entrada escalón
tiempo_pitch = [0, 1, 1, 10, 10, 20, 20, 30, 30, 40, 40, 50, 50 ,60];                % Tiempos de cambio de referencia en segundos
amplitud_pitch = deg2rad([0, 0, 5, 5, 0, 0, -2.5, -2.5, 0, 0, 10, 10, 0, 0]);        % Amplitudes correspondientes de ángulo de cabeceo en grados 
pitch_sp =timeseries(amplitud_pitch,tiempo_pitch);

    % Roll ref: se establece como una entrada escalón
tiempo_roll = [0, 1, 1, 3, 3, 5, 5, 7, 7, 9, 9, 15, 15, 20, 20, 25, 25, 35, 35, 45, 45, 55, 55, 60, 60, 65];                % Tiempos de cambio de referencia en segundos
amplitud_roll= deg2rad([0, 0, 5, 5, 0, 0, -5, -5, 0, 0, 10, 10, 0, 0, -10, -10, 0, 0, 20, 20, 0, 0, -20 ,-20, 0, 0]);       % Amplitudes correspondientes de ángulo de alabeo en grados
roll_sp = timeseries(amplitud_roll,tiempo_roll);
 
    % Velocidad ref: se establece como una entrada escalón
tiempo_vel = [0, 10, 10, 20, 20, 30, 30, 40];           % Tiempos de cambio de referencia en segundos 
amplitud_vel= [15, 15, 20, 20, 25, 25, 15, 15];         % Amplitudes correspondientes de velocidad en m/s
velocidad_sp = timeseries(amplitud_vel,tiempo_vel);

    % Throttle ref: se establece como un valor constante ya que este es
    % calculado por el control de posición.
throttle_sp = 0.6; 

% Sistema simulado 
    % Control longitudinal
clear ("pitch_P","pitch_I","pitch_D","tc_pitch","pitch_ff");

    % Controles laterales
clear("roll_P","roll_I","roll_D","tc_roll","roll_ff","yaw_P","yaw_I","yaw_D","yaw_ff");

     % Algoritmo genético
    InitSimulinkPlantVars           %Inicializa los parámetros del modelo de Simulink
    gaDat3.Objfun = 'Error_Medio_Cuadratico_tot';       %Función objetivo dinámica longitudinal y lateral
    lb3 = [lb_roll,lb_pitch,lb_yaw];
    ub3 = [ub_roll,ub_pitch,ub_yaw];
    gaDat3.FieldD = [lb3; ub3];
    % Se toman como población inicial las soluciones obtenidas en los
    % ajustes anteriores
    gaDat3.indini = [gaDat2.xmin(1),gaDat2.xmin(2),gaDat2.xmin(3),gaDat2.xmin(4),gaDat2.xmin(5),gaDat.xmin(1),gaDat.xmin(2),gaDat.xmin(3),gaDat.xmin(4),gaDat.xmin(5),gaDat2.xmin(6),gaDat2.xmin(7),gaDat2.xmin(8),gaDat2.xmin(9)];
    gaDat3.MAXGEN = 50;          % Número máximo de iteraciones 
    gaDat3.NIND = 175;           % Número de individuos por población, su valor estandar entre 150-200;
    gaDat3 = ga(gaDat3);
    gaDat3.xmin;  
    gaDat3.fxmin;

% Representación control y error
figure('Name','Control roll final')
subplot(3,2,1)
plot(gaDat3.xmingen(:,1))
grid on
title 'Roll\_P\_final'
xlabel 'Iteraciones'

subplot(3,2,3)
plot(gaDat3.xmingen(:,2))
grid on
title 'Roll\_I\_final'
xlabel 'Iteraciones'

subplot(3,2,5)
plot(gaDat3.xmingen(:,3))
grid on
title 'Roll\_D\_final'
xlabel 'Iteraciones'

subplot(3,2,2)
plot(gaDat3.xmingen(:,4))
grid on
title 'tc\_roll\_final'
xlabel 'Iteraciones'

subplot(3,2,4)
plot(gaDat3.xmingen(:,5))
grid on
title 'Roll\_ff\_final'
xlabel 'Iteraciones'

figure('Name','Control pitch final')
subplot(3,2,1)
plot(gaDat3.xmingen(:,6))
grid on
title 'Pitch\_P\_final'
xlabel 'Iteraciones'

subplot(3,2,3)
plot(gaDat3.xmingen(:,7))
grid on
title 'Pitch\_I\_final'
xlabel 'Iteraciones'

subplot(3,2,5)
plot(gaDat3.xmingen(:,8))
grid on
title 'Pitch\_D\_final'
xlabel 'Iteraciones'

subplot(3,2,2)
plot(gaDat3.xmingen(:,9))
grid on
title 'tc\_pitch\_final'
xlabel 'Iteraciones'

subplot(3,2,4)
plot(gaDat3.xmingen(:,10))
grid on
title 'Pitch\_ff\_final'
xlabel 'Iteraciones'

figure('Name','Control yaw final')
subplot(2,2,1)
plot(gaDat3.xmingen(:,11))
grid on
title 'Yaw\_P\_final'
xlabel 'Iteraciones'

subplot(2,2,3)
plot(gaDat3.xmingen(:,12))
grid on
title 'Yaw\_I\_final'
xlabel 'Iteraciones'

subplot(2,2,2)
plot(gaDat3.xmingen(:,13))
grid on
title 'Yaw\_D\_final'
xlabel 'Iteraciones'

subplot(2,2,4)
plot(gaDat3.xmingen(:,14))
grid on
title 'Yaw\_ff\_final'
xlabel 'Iteraciones'

figure('Name','Error final')
plot(gaDat3.fxmingen(:,1))
grid on
title 'Error\_final'
xlabel 'Iteraciones'

% Representación ángulo y rates
roll_P = gaDat3.xmin(1);
roll_I = gaDat3.xmin(2);
roll_D = gaDat3.xmin(3);
tc_roll = gaDat3.xmin(4);
roll_ff = gaDat3.xmin(5);
pitch_P = gaDat3.xmin(6);
pitch_I = gaDat3.xmin(7);
pitch_D = gaDat3.xmin(8);
tc_pitch = gaDat3.xmin(9);
pitch_ff = gaDat3.xmin(10);
yaw_P = gaDat3.xmin(11);
yaw_I = gaDat3.xmin(12);
yaw_D = gaDat3.xmin(13);
yaw_ff = gaDat3.xmin(14);

sim('FixedWing_Dynamic_Model_SIL_simulink');
Simulink_roll_sp = load('simulacionSimulink_roll_sp');
Simulink_pitch_sp = load('simulacionSimulink_pitch_sp');
Simulink_RPY = load('simulacionSimulink_RPY');
Simulink_rates_sp = load('simulacionSimulink_ratesRPY_sp');
Simulink_rates = load('simulacionSimulink_ratesRPY');

figure('Name','Ángulo final')
subplot(3,1,1)
plot(Simulink_roll_sp.ans.Time,Simulink_roll_sp.ans.Data(:)*180/pi,Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,1)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Roll [deg]'
title 'Ángulo alabeo final'
legend('ref','est')

subplot(3,1,2)
plot(Simulink_pitch_sp.ans.Time,Simulink_pitch_sp.ans.Data(:)*180/pi,Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,2)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Pitch [deg]'
title 'Ángulo cabeceo final'
legend('ref','est')

subplot(3,1,3)
plot(Simulink_RPY.ans.Time,Simulink_RPY.ans.Data(:,3)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Yaw [deg]'
title 'Ángulo guiñada final'
legend('est')

figure ('Name','Rate final')
subplot(3,1,1)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,1)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,1)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Roll rate [deg/s]'
title 'Velocidad alabeo final'
legend('ref','est')

subplot(3,1,2)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,2)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,2)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Pitch rate [deg/s]'
title 'Velocidad cabeceo final'
legend('ref','est')

subplot(3,1,3)
plot(Simulink_rates_sp.ans.Time,Simulink_rates_sp.ans.Data(:,3)*180/pi,Simulink_rates.ans.Time,Simulink_rates.ans.Data(:,3)*180/pi)
grid on
xlabel 'Tiempo [s]'
ylabel 'Yaw rate [deg/s]'
title 'Velocidad guiñada final'
legend('ref','est')