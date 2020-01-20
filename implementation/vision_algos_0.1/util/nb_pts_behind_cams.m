function nb = nb_pts_behind_cams(mot_m, str, imgs)

m = length(mot_m);
nb = [], 
for i = 1:m,
  pt_idx = imgs{i}(1,:);
  mot_m{i}*str(:, pt_idx); 
  nb = [nb,[length(find(ans(3,:)<0));length(imgs{i})]]; 
end


