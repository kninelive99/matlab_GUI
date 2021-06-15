close all; clear; clc;
sigma = 10; beta = 2.666666; rho = 28;
t = 30; dt = 0.02;
n = ceil(t/dt);
x1 = 1; y1 = 1; z1 = 1;

[x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1);

figure(1)
plot3(x,y,z)
xlabel('X'); ylabel('Y'); zlabel('Z')
grid on
text(0.05,0.8,0.9,'test string for GUI','units','normalized','fontsize',16)

function [x,y,z] = LS_E(sigma,beta,rho,n,dt,x1,y1,z1)
% LorenzSystem: Euler's schemes

x = zeros(1,n); y = zeros(1,n); z = zeros(1,n); 
x(1) = x1; y(1) = y1; z(1) = z1;
for i=2:n
    x(i) = x(i-1)+sigma*(y(i-1)-x(i-1))*dt;
    y(i) = y(i-1)+(rho*x(i-1)-x(i-1)*z(i-1)-y(i-1))*dt;
    z(i) = z(i-1)+(x(i-1)*y(i-1)-beta*z(i-1))*dt;
end
end