function plot_mot(mot,str,dims, mark_3D_pts,cam_idx)

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
%plot(str(d1,:), str(d2,:), 'g*'); hold on
plot(cam_cents(d1,:), cam_cents(d2,:), '44-'); 
if nargin==5,
 % plot(str(d1,mark_3D_pts), str(d2, mark_3D_pts), 'b*');
 hold on
  plot(cam_cents(d1,cam_idx), cam_cents(d2,cam_idx),'11')
end
hold off

