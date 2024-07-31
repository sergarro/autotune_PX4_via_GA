close all
%% Reprentaciones de las variables 

% Cargar valores
PX4_out = load('simulacionPX4_out.mat');
Simulink_out = load('simulacionSimulink_out.mat');
PX4_PWM = load('simulacionPX4_PWM.mat');
Simulink_PWM = load('simulacionSimulink_PWM.mat');
Simulink_VTAS_sp = load('simulacionSimulink_VTAS_sp.mat');
Simulink_hsp = load('simulacionSimulink_hsp.mat');

% Representaciones
% Ángulos de actitud
    % Phi
        figure
        subplot(3,1,1)
        plot(PX4_out.ans.phithetapsi.Time(:,:)-30,PX4_out.ans.phithetapsi.Data(:,1)*180/pi,Simulink_out.ans.phithetapsi.Time(:,:),Simulink_out.ans.phithetapsi.Data(:,1)*180/pi)
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'Phi [deg]'
        legend('PX4','Simulink')
        title('Alabeo')
        xlim([0,120])
    % Theta
       subplot(3,1,2)
        plot(PX4_out.ans.phithetapsi.Time(:,:)-30,PX4_out.ans.phithetapsi.Data(:,2)*180/pi,Simulink_out.ans.phithetapsi.Time(:,:),Simulink_out.ans.phithetapsi.Data(:,2)*180/pi)
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'Theta [deg]'
        legend('PX4','Simulink')
        title('Cabeceo')
        ylim([-10,25])
        xlim([0,120])

    % Psi
       subplot(3,1,3)
        plot(PX4_out.ans.phithetapsi.Time(:,:)-30,PX4_out.ans.phithetapsi.Data(:,3)*180/pi,Simulink_out.ans.phithetapsi.Time(:,:),Simulink_out.ans.phithetapsi.Data(:,3)*180/pi)
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'Psi [deg]' 
        legend('PX4','Simulink')
        title('Guiñada')
        xlim([0,120])


% Velocidad 

      figure
      plot(Simulink_out.ans.airspeed.Time(:,:),Simulink_out.ans.airspeed.Data(:,1),Simulink_VTAS_sp.ans.Time(:,:),Simulink_VTAS_sp.ans.Data(:,1),PX4_out.ans.airspeed.Time(:,:)-35,PX4_out.ans.airspeed.Data(:,1))
      grid on
      xlabel 'Tiempo [s]'
      ylabel 'Velocidad [m/s]'
      legend('Simulink','Referencia','PX4')
      title('Velocidad')
      xlim([0,120])

     
% Trayectoria
    % x vs y
        figure
        plot(Simulink_out.ans.xyzned.Data(:,2),Simulink_out.ans.xyzned.Data(:,1),PX4_out.ans.xyzned.Data(:,2),PX4_out.ans.xyzned.Data(:,1),poswp1(2),poswp1(1),'o',poswp2(2),poswp2(1),'o',poswp3(2),poswp3(1),'o',poswp4(2),poswp4(1),'o',poswp5(2),poswp5(1),'o',poswp6(2),poswp6(1),'o',poswp7(2),poswp7(1),'o',poswp8(2),poswp8(1),'o',poswp9(2),poswp9(1),'o')
        grid on 
        xlabel 'x [m]'
        ylabel 'y [m]'
        legend('Simulink','PX4','wp1','wp2','wp3','wp4','wp5','wp6','wp7','wp8','wp9')
        title('Trayectoria x-y')

        
    % x vs z
         figure
        plot(Simulink_out.ans.xyzned.Time(:,:),-Simulink_out.ans.xyzned.Data(:,3),PX4_out.ans.xyzned.Time(:,:)-35,-PX4_out.ans.xyzned.Data(:,3),Simulink_hsp.ans.Time(:,:),Simulink_hsp.ans.Data(:,1))
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'z [m]'
        legend('Simulink','PX4','Altitud\_sp')
        title('Altitud')
        disp(poswp);
        xlim([0,120])
        
% PWM
figure
    subplot(2,2,1)
    plot(PX4_PWM.ans.Time(:,:)-30,PX4_PWM.ans.Data(:,1),Simulink_PWM.ans.Time(:,:),Simulink_PWM.ans.Data(:,1))
    grid on 
    ylim([-1 1]) 
    legend('PX4','Simulink')
    title('dE')
     xlabel 'Tiempo [s]'
     xlim([0,120])


    subplot(2,2,2)
    plot(PX4_PWM.ans.Time(:,:)-30,PX4_PWM.ans.Data(:,2),Simulink_PWM.ans.Time(:,:),Simulink_PWM.ans.Data(:,2))
    grid on 
    ylim([-1 1]) 
    legend('PX4','Simulink')
    title('dA')
    xlabel 'Tiempo [s]'
    xlim([0,120])


    subplot(2,2,4)
    plot(PX4_PWM.ans.Time(:,:)-30,PX4_PWM.ans.Data(:,3),Simulink_PWM.ans.Time(:,:),Simulink_PWM.ans.Data(:,3))
    grid on 
    ylim([-1 1]) 
    legend('PX4','Simulink')
    title('dR')
    xlabel 'Tiempo [s]'
    xlim([0,120])


    subplot(2,2,3)
    plot(PX4_PWM.ans.Time(:,:)-30,PX4_PWM.ans.Data(:,4),Simulink_PWM.ans.Time(:,:),Simulink_PWM.ans.Data(:,4))
    grid on 
    ylim([-0.1 1.1])
    legend('PX4','Simulink')
    title('dP')
    xlabel 'Tiempo [s]'
    xlim([0,120])


   