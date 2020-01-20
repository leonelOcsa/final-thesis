function q = angle_axis_to_quaternion(theta, a)

a = a/norm(a);

sint = sin(theta/2);
q = [cos(theta/2); a*sint];

q = q/norm(q); %make sure norm(q)==1 (rounding errors).
