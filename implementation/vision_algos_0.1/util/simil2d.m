function H = simil2d(A,B)

%find the similarity transformation between the 2 sets of points A and B
%A = [x11 x12; y11 y12], B = [x21 x22; y21 y22];

v1 = diff(A'); v2 = diff(B');

s = norm(v2)/norm(v1);

theta = sign(det([v1' v2']))*acos(v1*v2'/norm(v1)/norm(v2));

s*[cos(theta) -sin(theta); sin(theta) cos(theta)]*A-B;
t = -ans(:,1);
H = [s*[cos(theta) -sin(theta); sin(theta) cos(theta)], t; 0 0 1];

