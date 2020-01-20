function [imgstmp, new_str] = select_pts_in_front(mot_m, str, imgs)

imgstmp = imgs;

m = length(mot_m);

for i = 1:m,

  pt_idx = imgs{i}(1,:);
  mot_m{i}*str(:, pt_idx); 
  imgstmp{i} = imgs{i}(:,find(ans(3,:)>0));
end

[imgstmp, new_str] = remove_singles(imgstmp, 2, str);
