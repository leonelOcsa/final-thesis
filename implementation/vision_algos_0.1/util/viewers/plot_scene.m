function plot_scene(mot,str,dims, mark_3D_pts,cam_idx)

m =length(mot);

cam_cents = [];

for i = 1:m
%  keyboard
  tmp = mot{i}{2};
  cam_cents = [cam_cents, tmp];
end
%keyboard
d1 = dims(1);
d2 = dims(2);
figure; hold off
plot(str(d1,:), str(d2,:), 'g*'); hold on
try
  plot(cam_cents(d1,:), cam_cents(d2,:), '54-'); 
catch
end
if nargin==5,
  try
    plot(str(d1,mark_3D_pts), str(d2, mark_3D_pts), '4*');
    plot(cam_cents(d1,cam_idx), cam_cents(d2,cam_idx),'b1')
  catch
  end
end
hold off

