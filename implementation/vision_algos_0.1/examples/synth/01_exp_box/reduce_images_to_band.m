function new_imgs = reduce_images_to_band(imgs, nb_pts)


m  = length(imgs);
new_imgs = cell(m,1);
transl_size = floor((size(imgs{1},2)-nb_pts)/(m-1));

for i = 1:m,
  new_imgs{i} = imgs{i}(:, (i-1)*transl_size+1:(i-1)*transl_size+nb_pts);
end


