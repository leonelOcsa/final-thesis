function [imgs, new_str] = remove_singles(imgs, min_nb_frames, str)

%function [imgs] = remove_singles(imgs, min_nb_frames)
%removes features from imgs, which are not present in at least min_nb_frames

m = length(imgs);

all_img_idx = [];
for i = 1:length(imgs),
tmp = imgs{i}(1,:);
all_img_idx = [all_img_idx, tmp ];
end


%FIXME: optimisation: call histogram function.
histo = zeros(1, max(all_img_idx));
for i=1:length(all_img_idx)
  histo(all_img_idx(i)) = histo(all_img_idx(i)) +1;
end
valid_indices = find(histo>=min_nb_frames);




for i = 1:m,
  [dummy, idx] = sort(imgs{i}(1,:));
  imgs{i} = imgs{i}(:,idx);
  [dummy, imgs{i}] = select_common_features(valid_indices, imgs{i});
end
if nargin ==3, 
[imgs, new_str] = reorder_img_indices(imgs,str);
else
  imgs = reorder_img_indices(imgs);
end


