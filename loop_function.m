function [x,y,z,s_new,abs_G] = loop_function(s_0, z_0, x_0, y_0, g, r)
circ = 2*pi*r;
s_new = linspace(0,circ,1000);
theta = zeros(1,length(s_new));
z = zeros(1,length(theta));
x = zeros(1,length(theta));
y = zeros(1,length(theta));
y(:) = y_0;

for i = 1:length(s_new)
    if s_new(i) <= 0.25*circ
        theta(i) = (0.25*circ-s_new(i)) ./ r;
        z(i) = z_0 + (r-r*sin(theta(i)));
        x(i) = x_0 + r*cos(theta(i));
    elseif s_new(i) <= 0.5*circ
        theta(i) = (s_new(i)-0.25*circ) ./ r;
        z(i) = z_0 + (r+r*sin(theta(i)));
        x(i) = x_0 + r*cos(theta(i));
    elseif s_new(i) <= 0.75*circ
        theta(i) = (0.75*circ-s_new(i)) ./ r;
        z(i) = z_0 + (r+r*sin(theta(i)));
        x(i) = x_0 - r*cos(theta(i));
    else
        theta(i)  = (s_new(i)-0.75*circ) ./ r;
        z(i) = z_0 + (r-r*sin(theta(i)));
        x(i) = x_0 - r*cos(theta(i));
    end
end

v = sqrt(2*g.*(125-z));
abs_G = zeros(1,length(s_new));

for i = 1:length(abs_G)
    if z(i) >= r
        abs_G(i) = v(i)^2 / (g*r) - sin(theta(i));
    else
        abs_G(i) = v(i)^2 / (g*r) + sin(theta(i));
    end
end

s_new = s_new + s_0;

end