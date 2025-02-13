  clc 
  clear  
%% initialize values 
    y0 = 70;
    x0 = 5;
    v0 = sqrt(2*9.81*(125-y0));
    g = 9.81;
    theta0 = 45;

    % xf = x0 + (v0^2*sind(2*theta0))/g;
    x = linspace(x0,xf,1000); 

    v0y = v0*sind(theta0);
    v0x = v0*cosd(theta0);
    t = (x - x0)/v0x;

    y = y0 + v0y * t - 4.9*(t.^2);
    dydx = (v0y / v0x) - ((9.8 / v0x.^2)*(x-x0)); 
    dydx2 = (-9.8/v0x.^2);
   
    ynew = sqrt(dydx.^2);
    s = cumtrapz(x,ynew);
    arclength = s(end)

    r = (((1+(dydx.^2)).^(3/2))./(abs(dydx2)));
    v = sqrt(2*g*(125-y));

    figure()
    plot(x,y)

    %% Up and down gs  
    
    UDgs = v.^2 ./ g .* r;

    figure(2);
    subplot(3,1,1)

    plot(s,UDgs)
    %% Left and right gs 
    LRgs = (v.^2 / g .* r) - 1;

    subplot(3,1,2)
    plot(s,LRgs)

    %% Lateral gs
    latgs = zeros(length(x));

    subplot(3,1,3)
    plot(s,latgs)

 