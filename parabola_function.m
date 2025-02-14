function [x,y,z,s_new,abs_G] = parabola_function(s_0, z_0, x_0, y_0, g, t_end)
    z0 = z_0;
    x0 = x_0;
    y0 = y_0;
    s0 = s_0;
    v0 = sqrt(2*g*(125-z0));
    t = linspace(0, t_end, 1000);
    theta_approach = 45;

    v0z = v0*sind(theta_approach);
    v0x = v0*cosd(theta_approach);
    v0y = 0;

    z = z0 + v0z .* t - (0.5) .* g .* t.^2;
    x = x0 + v0x .* t;
    y = y0 + v0y .* t;
    tx = (x - x0)./v0x;
    
    zx = z0 + v0z .* tx - (0.5) .* g .* tx.^2;
    dzdx = (v0z / v0x) + g*(x0-x)./(v0x.^2);
    dzdx2 = (-g/v0x.^2);
   
    s_new = zeros(1,length(t));
    s_new(1) = s0 + sqrt((x(1)-x0)^2 + (z(1)-z0)^2);
    for i = 1:length(t)-1
        s_new(i+1) = s_new(i) + sqrt((x(i+1)-x(i))^2 + (z(i+1)-z(i))^2);
    end

    r = (((1+(dzdx.^2)).^(3/2))./(abs(dzdx2)));
    v = sqrt(2*g*(125-zx));

    % Normal gs  
    %{
    theta = zeros(1,length(r(2:end)));
    
    for i = 1:length(theta)-1
        theta(i+1) = theta(i) + sqrt((x(i+1)-x(i)).^2+(z(i+1)-z(i)).^2) ./ r(i+1);
    end
    %}
    theta = asin(v.^2 ./ (g.*r));
    
    abs_G = (-v.^2)/(g.*r) + sin(theta);

end