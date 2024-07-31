function ECMt = Error_Medio_Cuadratico_lat(p)
 % Valores controladores 
roll_P = p(1);
roll_I = p(2);
roll_D = p(3);
tc_roll = p(4);
roll_ff = p(5);
yaw_P = p(6);
yaw_I = p(7);
yaw_D = p(8);
yaw_ff = p(9);

    % Guardar variables en workspace para ser utilizadas en la simulación
assignin("base","roll_P",roll_P);
assignin("base","roll_I",roll_I);
assignin("base","roll_D",roll_D);
assignin("base","tc_roll",tc_roll);
assignin("base","roll_ff",roll_ff);
assignin("base","yaw_P",yaw_P);
assignin("base","yaw_I",yaw_I);
assignin("base","yaw_D",yaw_D);
assignin("base","yaw_ff",yaw_ff);

    % Simular el sistema
sim('FixedWing_Dynamic_Model_SIL_simulink');

    % Cargar los resultados
Simulink_roll_sp = load('simulacionSimulink_roll_sp');
Simulink_RPY = load('simulacionSimulink_RPY');
Simulink_rates_sp = load('simulacionSimulink_ratesRPY_sp');
Simulink_rates = load('simulacionSimulink_ratesRPY');
Ysp = [Simulink_roll_sp.ans.Data(:),Simulink_rates_sp.ans.Data(:,1),Simulink_rates_sp.ans.Data(:,3)];
Yest = [Simulink_RPY.ans.Data(:,1),Simulink_rates.ans.Data(:,1),Simulink_rates.ans.Data(:,3)];

%Obtener error cuadrático medio
[dimYrow,dimYcol] = size(Ysp);
ECM = zeros(dimYrow,dimYcol);
n = dimYrow;
for i = 1:dimYrow
ECM(i,:) = (Yest(i,:)-Ysp(i,:)).*(Yest(i,:)-Ysp(i,:));
end
ECMp = 1/n*sum(ECM);

ECMt = 0;
for i = 1:dimYcol
    ECMt = ECMt+ECMp(:,i);
end
end