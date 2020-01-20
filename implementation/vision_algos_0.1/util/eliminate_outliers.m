function [new_imgs, str_new] = eliminate_outli
ers(imgs, mot, str, nb_eliminated)

%str = X_proj
%mot = mot_proj

m = length(imgs);

%find image points to be eliminated:
%generate a table with all indices in all frames and corresp. repro error.
% tbl: [frame_idx, point_idx, repro_err]
tbl = [];

for i = 1:m,
  pt_indices = imgs{i}(1,:);
  err = pflat(mot{i}*str(:,pt_indices))-imgs{i}(2:4, :);
  tbl = [tbl; ones(length(pt_indices),1)*i, pt_indices', sum(err.^2)'];
end

%sort the list/table in order to find most erroneous img points
[slask, sorted_indices] = sort(tbl(:,3));

tbl = tbl(sorted_indices, :); tbl = flipud(tbl);

new_imgs = imgs;
%eliminate the image points
for i = 1:nb_eliminated,
  frm = tbl(i,1); pt_idx = tbl(i,2);
  pt_pos_idx = find(new_imgs{frm}(1,:)==pt_idx);
    new_imgs{frm} = [new_imgs{frm}(:,1:pt_pos_idx-1) new_imgs{frm}(:,pt_pos_idx+
1:end)];
end

%eliminate 3D point if support in imgs is insufficient (<2)
%i.e. eliminate singles and re-intersect. todo: optimise, intersection not 
%necessary
[new_imgs, str_new] = remove_singles(new_imgs, 2, str);

