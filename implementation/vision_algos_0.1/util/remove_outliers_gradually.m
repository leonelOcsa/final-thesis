function [imgs, intr, mot, str] = remove_outliers_gradually(imgs, intr, mot, str, intr_spec, nb_iter, nb_out_per_step, lambda0)

%function [imgs, intr, mot, str] = remove_outliers_gradually(imgs, intr, mot, str, intr_spec, nb_iter, nb_out_per_step, lambda0)

for i = 1:nb_iter,
  i
  tmp = mot_mats(mot, intr);
  [rec, rec_idx] = get_err(imgs, tmp, str); mean(rec);
  [rec, sorting_idx] = sort(rec);
  rec_idx = rec_idx(:, sorting_idx);
  for j=length(rec)-nb_out_per_step+1:length(rec),%remove the indices
    tmp_img = imgs{rec_idx(1,j)};
    tmp_img = tmp_img(:,find(tmp_img(1,:)~=rec_idx(2,j)));
    imgs{rec_idx(1,j)} = tmp_img;
  end

  %finally remove possible singles
  imgs = remove_singles(imgs, 1);
  [intr, mot, str] = bundle_eucl(imgs, mot, intr, str, intr_spec, 1, lambda0);
end
