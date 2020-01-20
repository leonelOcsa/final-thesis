function [mot_eucl] = affine_to_eucl(mot_affine, focal)

m = length(mot_affine);
mot_eucl = cell(m,1);
for i = 1:m,
  v1 = mot_affine{i}(1,1:3);
  v2 = mot_affine{i}(2,1:3);
  cal = zeros(2);
  cal(2,2) = norm(v2);
  cal(1,2) = v1*v2'/norm(v2);
  cal(1,1) = norm(cross(v1,v2))/norm(v2);
  R = cal\[v1;v2];
if nargin ==2;
  f = focal;
else
  f = 1
end
  R = [R; cross(R(1,:),R(2,:))/f*cal(1,1)];
  tmp = mot_affine{i}(1:3, 4);
  mot_eucl{i} = [[cal, [0 0]'; 0 0 1 ]*R, tmp];
end

