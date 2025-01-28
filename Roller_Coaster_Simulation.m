%% ASEN 2803 Dynamics Lab 1 Simulation
clc;
clear;

%% Initial Values
x0 = 0; % initial x value (meters)
y0 = 0; % initial y value (meters)
z0 = 125; % initial z value (meters)
v0 = 0; % initial velocity (m/s)
track_len = 0; % UPDATE THIS AS YOU ADD TRACK

% max G forces
max_forward = 5; % back of seat
max_back = 4; % bar toward back
max_up = 6; % up through seat
max_down = 1; % down from bar
max_lat = 3; % left or right of rider

max_length = 1250; % meters
position = zeros(max_length,3); % matrix of positions over time
position(1,:) = [x0 y0 z0];

%% Zero G Parabola


%% Loop


%% Banked Turn
