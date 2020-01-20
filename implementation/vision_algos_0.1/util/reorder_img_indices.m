function [imgs, new_str] = reorder_img_indices(imgs, old_str)

img_idx_set = [];
for i = 1:length(imgs),
  tmp = imgs{i}(1,:);
  img_idx_set = unique([img_idx_set,tmp]);
end

img_idx_set = sort(img_idx_set);
%keyboard

for i = 1:length(imgs),
  for j = 1:size(imgs{i},2),
    imgs{i}(1,j) = find(img_idx_set==imgs{i}(1,j));
  end
end

if nargin==2,
  new_str = old_str(:,img_idx_set);
end
