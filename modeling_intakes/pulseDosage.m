clc;
clear all;
k = 0.14;
dos = 4;
tb = (15/60)/2;
tp = 4;
dos = dos*tp/tb;
syms('K');
syms('L21');
syms('L12');
syms('V1');
syms('V2');
syms('d');
syms('K');
A= double(subs(subs(subs(subs(subs([-(K + L12)/V1 L21/V2; L12/V1 -L21/V2], 'K', k), 'L21', 0.3), 'L12', 0.27), 'V1', 5), 'V2', 0.2));
B= double(subs([1; 0], 'V1', 5));
C1=[1 0];
C2=[0 1];
D=0;
mySys=ss(A,B,C1,D);
mySys2=ss(A,B,C2,D);
q0=[2; 5;];
t=linspace(0,72,10000);
temp = size(t);
u=zeros(temp(2), 1);


for i=1:temp(2)
    m = mod(t(i), tp);
    if ((0 <= m) && m < tb)
        u(i) = dos;
    else
        u(i) = 0;
    end;
end;
u = u/5;
yzi1=initial(mySys,q0,t);
yzs1=lsim(mySys,u,t);
yc1=yzi1+yzs1;
yzi2=initial(mySys2,q0,t);
yzs2=lsim(mySys2,u,t);
yc2=yzi2+yzs2;
figure(1);
hold on;
    subplot(2,2,1);
    plot(t, u, 'color', 'blue');
    title('Input');
    xlabel('time (hr)');
    ylabel('Concentration (mg/L)');
    subplot(2,2,2);
    hold on;
        plot(t, yc1, 'color', 'blue');
        plot(t, yc2, 'color', 'red');
        title('Complete Response');
        xlabel('time (hr)');
        ylabel('Concentration (mg/L)');
        legend('Blood', 'Brain');
    hold off;
    subplot(2,2,3);
    hold on;
        plot(t, yzi1, 'color', 'blue');
        plot(t, yzi2, 'color', 'red');
        title('Zero-Input');
        xlabel('time (hr)');
        ylabel('Concentration (mg/L)');
        legend('Blood', 'Brain');
    hold off;
    subplot(2,2,4);
    hold on;
        plot(t, yzs1, 'color', 'blue');
        plot(t, yzs2, 'color', 'red');
        title('Zero-State');
        xlabel('time (hr)');
        ylabel('Concentration (mg/L)');
        legend('Blood', 'Brain');
    hold off;
hold off;
%yc1(temp(2))
%yc2(temp(2))
