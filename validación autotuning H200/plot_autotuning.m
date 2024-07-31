close all
PX4_out = load('simulacionPX4_out.mat');
PX4_out_ref = load('simulacionPX4_out_ref.mat');
PX4_PWM = load('simulacionPX4_PWM.mat');
PX4_PWM_ref = load('simulacionPX4_PWM_ref.mat');
Simulink_out = load('simulacionSimulink_out.mat');
Simulink_out_ref = load('simulacionSimulink_out_ref.mat');

        figure
        plot(PX4_out.ans.xyzned.Data(:,2),PX4_out.ans.xyzned.Data(:,1),PX4_out_ref.ans.xyzned.Data(:,2),PX4_out_ref.ans.xyzned.Data(:,1),poswp1(2),poswp1(1),'o',poswp2(2),poswp2(1),'o',poswp3(2),poswp3(1),'o',poswp4(2),poswp4(1),'o',poswp5(2),poswp5(1),'o',poswp6(2),poswp6(1),'o',poswp7(2),poswp7(1),'o',poswp8(2),poswp8(1),'o',poswp9(2),poswp9(1),'o')
        grid on 
        xlabel 'x [m]'
        ylabel 'y [m]'
        legend('PX4\_auto-tuning','PX4','wp1','wp2','wp3','wp4','wp5','wp6','wp7','wp8','wp9')
        
         figure
        plot(Simulink_out.ans.xyzned.Data(:,2),Simulink_out.ans.xyzned.Data(:,1),PX4_out.ans.xyzned.Data(:,2),PX4_out.ans.xyzned.Data(:,1),poswp1(2),poswp1(1),'o',poswp2(2),poswp2(1),'o',poswp3(2),poswp3(1),'o',poswp4(2),poswp4(1),'o',poswp5(2),poswp5(1),'o',poswp6(2),poswp6(1),'o',poswp7(2),poswp7(1),'o',poswp8(2),poswp8(1),'o',poswp9(2),poswp9(1),'o')
        grid on 
        xlabel 'x [m]'
        ylabel 'y [m]'
        legend('Simulink\_auto-tuning','PX4\_auto-tuning','wp1','wp2','wp3','wp4','wp5','wp6','wp7','wp8','wp9')

         figure
        plot(PX4_out.ans.xyzned.Time(:,:),-PX4_out.ans.xyzned.Data(:,3),PX4_out_ref.ans.xyzned.Time(:,:)-10 ,-PX4_out_ref.ans.xyzned.Data(:,3))
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'z [m]'
        legend('PX4\_auto-tuning','PX4')
        title('Altitud')

         figure
        plot(PX4_out.ans.xyzned.Time(:,:)-18,-PX4_out.ans.xyzned.Data(:,3),Simulink_out.ans.xyzned.Time(:,:),-Simulink_out.ans.xyzned.Data(:,3))
        grid on 
        xlabel 'Tiempo [s]'
        ylabel 'z [m]'
        legend('PX4\_auto-tuning','Simulink\_auto-tuning')
        title('Altitud')

        figure
      plot(PX4_out.ans.airspeed.Time(:,:),PX4_out.ans.airspeed.Data(:,1),PX4_out_ref.ans.airspeed.Time(:,:)-10 ,PX4_out_ref.ans.airspeed.Data(:,1))
      grid on
      xlabel 'Tiempo [s]'
      ylabel 'Velocidad [m/s]'
      legend('PX4\_auto-tuning','PX4')
      title('Velocidad')

      figure
      plot(PX4_out.ans.airspeed.Time(:,:)-18,PX4_out.ans.airspeed.Data(:,1),Simulink_out.ans.airspeed.Time(:,:),Simulink_out.ans.airspeed.Data(:,1))
      grid on
      xlabel 'Tiempo [s]'
      ylabel 'Velocidad [m/s]'
      legend('PX4\_auto-tuning','Simulink\_auto-tuning')
      title('Velocidad')