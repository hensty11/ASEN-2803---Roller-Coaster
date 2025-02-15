%% ASEN 2803 Dynamics Lab 1 Simulation
clc;
clear;
close all;

%% Initial Values
x = (0); % initial x value (meters)
y = (0); % initial y value (meters)
h_0 = 125; % initial z value (meters)
z = (125);
v0 = 0; % initial velocity (m/s)
g = 9.81; % gravity (m/s^2)
% m = 1; % mass of cart (kg)

% max G forces
max_forward = 5; % back of seat
max_back = 4; % bar toward back
max_up = 6; % up through seat
max_down = 1; % down from bar
max_lat = 3; % left or right of rider
max_length = 1250; % meter

s = (0); % UPDATE THIS AS YOU ADD TRACK (wet length of track)
G_normal = (0);
G_tangential = (0);
G_lateral = (0);


%% Transition into Parabola
% entrance curve
r_enter = 10;
l_enter = linspace(0, r_enter*pi/2, 100);
theta_enter = pi/2 - l_enter ./ r_enter;
z_enter = z(end) - r_enter + r_enter .* sin(theta_enter);
x_enter = x(end) + r_enter .* cos(theta_enter);
v_enter = sqrt(2*g.*(h_0-z_enter));
G_enter = -v_enter.^2./(g*r_enter) + sin(theta_enter);
s = [s s(end)+l_enter];

% free fall
l_fall = linspace(0,30,50);
z_fall = z_enter(end) - l_fall;
x_fall = z_fall;
x_fall(:,:) = x_enter(end);
G_fall = zeros(1,length(z_fall));
s = [s s(end)+l_fall];

% exit curve
r_exit = 40;
l_exit = linspace(0,r_exit*3*pi/4,150);
theta_exit = l_exit ./ r_exit;
z_exit = z_fall(end) - r_exit .* sin(theta_exit);
x_exit = x_fall(end) + r_exit - r_exit .* cos(theta_exit);
v_exit = sqrt(2*g.*(h_0-z_exit));
G_exit = v_exit.^2./(g*r_exit) + sin(theta_exit);
s = [s s(end)+l_exit];

x = [x x_enter x_fall x_exit];
y = zeros(1,length(x));
z = [z z_enter z_fall z_exit];
G_normal = [G_normal G_enter G_fall G_exit];
G_lateral = zeros(1,length(G_normal));
G_tangential = zeros(1,length(G_normal));

%% Zero G Parabola
s_0 = s(end);
z_0 = z(end);
x_0 = x(end);
y_0 = y(end);
t_end = 4.8;

[x_new,y_new,z_new,s_new,abs_G] = parabola_function(s_0, z_0, x_0, y_0, g, t_end);
s = [s s_new];
x = [x x_new];
y = [y y_new];
z = [z z_new];
G_normal = [G_normal abs_G];
G_tangential = [G_tangential zeros(1,length(s_new))];
G_lateral = [G_lateral zeros(1,length(s_new))];

% Plotting
figure(1);
subplot(3,1,1);
plot(s_new, abs_G)
title("Normal Forces acting on parabola")
subplot(3,1,2);
plot(s_new, zeros(1,length(s_new)));
title("Tangential Forces acting on parabola")
ylabel("Gs Experienced")
subplot(3,1,3);
plot(s_new, zeros(1,length(s_new)));
title("Lateral Forces acting on parabola")
xlabel("s Position (m)")


%% Transition into Loop
r_exit2 = 40;
exit_angle = atan((x(end)-x(end-20))/(z(end-20)-z(end)));
l_exit2 = linspace(r_exit2*exit_angle,r_exit2*pi/2,150);
theta_exit2 = l_exit2 ./ r_exit2;
z(end)
z_exit2 = z(end) - r_exit2 .* sin(theta_exit2) + r_exit2*sin(exit_angle);
x(end)
x_exit2 = x(end) + r_exit2 - r_exit2 .* cos(theta_exit2) - ( r_exit2- r_exit2*cos(exit_angle));
v_exit2 = sqrt(2*g.*(h_0-z_exit2));
G_exit2 = v_exit2.^2./(g*r_exit2) + sin(theta_exit2);
s = [s s(end)+l_exit2];

x = [x x_exit2];
y = zeros(1,length(x));
z = [z z_exit2];
G_normal = [G_normal G_exit2];
G_lateral = zeros(1,length(G_normal));
G_tangential = zeros(1,length(G_normal));


%% Loop
s_0 = s(end);
z_0 = z(end);
x_0 = x(end);
y_0 = y(end);
r = 25;

[x_new,y_new,z_new,s_new,abs_G] = loop_function(s_0, z_0, x_0, y_0, g, r);
s = [s s_new];
x = [x x_new];
y = [y y_new];
z = [z z_new];
G_normal = [G_normal abs_G];
G_tangential = [G_tangential zeros(1,length(s_new))];
G_lateral = [G_lateral zeros(1,length(s_new))];

% Plotting
figure(2);
subplot(3,1,1);
plot(s_new, abs_G)
title("Normal Forces acting on loop")
subplot(3,1,2);
plot(s_new, zeros(1,length(s_new)));
title("Tangential Forces acting on loop")
ylabel("Gs Experienced")
subplot(3,1,3);
plot(s_new, zeros(1,length(s_new)));
title("Lateral Forces acting on loop")
xlabel("s Position (m)")


%% Banked Turn
r_bank = 32; % radius of curve (m)
s_bank = linspace(0,r_bank*pi,1000);
theta_curve = s_bank ./ r_bank;
vi = sqrt(2*g.*(h_0-z(end))); % velocity entering segment (m/s)
theta = acot(r_bank*g./(vi.^2)); % angle of bank (degrees)
G_bank = zeros(1, length(s_bank));
G_bank(:) = 1./cos(theta);
x_bank = r_bank .* sin(theta_curve);
y_bank = r_bank - r_bank .* cos(theta_curve);

s_new = s(end)+s_bank;
s = [s s_new];
x = [x x(end)+x_bank];
y = [y y(end)+y_bank];
z = [z z(end)+zeros(1,length(x_bank))];
G_normal = [G_normal G_bank];
G_lateral = zeros(1,length(G_normal));
G_tangential = zeros(1,length(G_normal));

% Plotting
figure(3);
subplot(3,1,1);
plot(s_new, G_bank)
title("Normal Forces acting on banked turn")
subplot(3,1,2);
plot(s_new, zeros(1,length(s_new)));
title("Tangential Forces acting on banked turn")
ylabel("Gs Experienced")
subplot(3,1,3);
plot(s_new, zeros(1,length(s_new)));
title("Lateral Forces acting on banked turn")
xlabel("s Position (m)")


%% Breaking section 1
breaking_start = s(end); % start length of track of breaking
deceleration = 0.5* max_forward * -g;
vi = sqrt(2*g*(h_0-z(end)));
stop_dist = vi*(vi/-deceleration) + 0.5*deceleration*(vi/-deceleration)^2;
breaking_end = breaking_start + stop_dist;

l_break = linspace(breaking_start, breaking_end, 1000);
G_break = zeros(1,length(l_break));
G_break(:) = 0.5 * deceleration / g;
G_tangential = [G_tangential G_break];
G_normal = [G_normal 1+zeros(1,length(G_break))];
G_lateral = [G_lateral G_lateral(end)+zeros(1,length(G_break))];
s = [s l_break];

x_break = x(end) - linspace(0, stop_dist, 1000);
x = [x x_break];
z = [z z(end)+zeros(1,length(x_break))];
y = [y y(end)+zeros(1,length(x_break))];
h_1 = z(end);


%% Transition to ground
% entrance curve
r_enter = 20;
l_enter = linspace(0, r_enter*pi/2, 100);
theta_enter = pi/2 - l_enter ./ r_enter;
z_enter = z(end) - r_enter + r_enter .* sin(theta_enter);
x_enter = x(end) - r_enter .* cos(theta_enter);
v_enter = sqrt(2*g.*(h_1-z_enter));
G_enter = -v_enter.^2./(g*r_enter) + sin(theta_enter);
s = [s s(end)+l_enter];

% exit curve
r_exit = z(end)-r_enter;
l_exit = linspace(0,r_exit*pi/2,100);
theta_exit = l_exit ./ r_exit;
z_exit = z_enter(end) - r_exit .* sin(theta_exit);
x_exit = x_enter(end) - r_exit + r_exit .* cos(theta_exit);
v_exit = sqrt(2*g.*(h_1-z_exit));
G_exit = v_exit.^2./(g*r_exit) + sin(theta_exit);
s = [s s(end)+l_exit];

x = [x x_enter x_exit];
y = [y y(end)+zeros(1,length(x_enter)+length(x_exit))];;
z = [z z_enter z_exit];
G_normal = [G_normal G_enter G_exit];
G_lateral = zeros(1,length(G_normal));
G_tangential = [G_tangential zeros(1,length(G_enter)+length(G_exit))];

%% Breaking section 2
breaking_start = s(end); % start length of track of breaking
deceleration = 0.3* max_forward * -g;
vi = sqrt(2*g*(h_0-z(end)));
stop_dist = vi*(vi/-deceleration) + 0.5*deceleration*(vi/-deceleration)^2;
breaking_end = breaking_start + stop_dist;

l_break = linspace(breaking_start, breaking_end, 1000);
G_break = zeros(1,length(l_break));
G_break(:) = 0.3 * deceleration / g;
G_tangential = [G_tangential G_break];
G_normal = [G_normal 1+zeros(1,length(G_break))];
G_lateral = [G_lateral G_lateral(end)+zeros(1,length(G_break))];
s = [s l_break];

x_break = x(end) - linspace(0, stop_dist, 1000);
x = [x x_break];
z = [z z(end)+zeros(1,length(x_break))];
y = [y y(end)+zeros(1,length(x_break))];

s_new = l_break;
% Plotting
figure(4);
subplot(3,1,1);
plot(s_new, 1+zeros(1,length(G_break)))
title("Normal Forces acting on breaking")
subplot(3,1,2);
plot(s_new, G_break);
title("Tangential Forces acting on breaking")
ylabel("Gs Experienced")
subplot(3,1,3);
plot(s_new, zeros(1,length(s_new)));
title("Lateral Forces acting on breaking")
xlabel("s Position (m)")

%% Figures
figure(5)
plot3(x,y,z)
grid on;
title("xyz Position")
xlabel('x Position (m)')
ylabel('y Position (m)')
zlabel('z Position (m)')
 
figure(6)
plot(s,G_normal)
title("Normal Gs Over s")
xlabel('s Position (m)')
ylabel('Normal Gs')
 
figure(7)
plot(s,G_tangential)
title("Tangential Gs Over s")
xlabel('s Position (m)')
ylabel('Tangential Gs')
 
figure(8)
plot(s,G_lateral)
title("Lateral Gs Over s")
xlabel('s Position (m)')
ylabel('Lateral Gs')
