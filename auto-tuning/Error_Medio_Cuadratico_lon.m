function ECMt = Error_Medio_Cuadratico_lon(p)

% Dinámica longitudinal 
    % Valores controladores 
pitch_P = p(1);
pitch_I = p(2);
pitch_D = p(3);
tc_pitch = p(4);
pitch_ff = p(5);

    % Guardar variables en workspace para ser utilizadas en la simulación
assignin("base","pitch_P",pitch_P);
assignin("base","pitch_I",pitch_I);
assignin("base","pitch_D",pitch_D);
assignin("base","tc_pitch",tc_pitch);
assignin("base","pitch_ff",pitch_ff);

    % Simular el sistema
sim('FixedWing_Dynamic_Model_SIL_simulink');

    % Cargar los resultados
Simulink_pitch_sp = load('simulacionSimulink_pitch_sp');
Simulink_RPY = load('simulacionSimulink_RPY');
Simulink_rates_sp = load('simulacionSimulink_ratesRPY_sp');
Simulink_rates = load('simulacionSimulink_ratesRPY');
Ysp = [Simulink_pitch_sp.ans.Data(:),Simulink_rates_sp.ans.Data(:,2)];
Yest = [Simulink_RPY.ans.Data(:,2),Simulink_rates.ans.Data(:,2)];

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