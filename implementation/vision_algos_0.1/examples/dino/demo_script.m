base_path  = '../../'

path(path, [base_path 'affine_reconst']);
path(path, [base_path 'bundle']);
path(path, [base_path 'bundle/jac']);
path(path, [base_path 'bundle/err']);
path(path, [base_path 'bundle/solve']);
path(path, [base_path 'bundle/update']);
path(path, [base_path 'util']);
path(path, [base_path 'util/viewers']);
path(path, [base_path 'tracker']);


more off

imgs = read_image_data_from_file('dino.tks'); m = length(imgs)
imgs = remove_singles(imgs,3);
imgstmp = imgs;


x0 = 576/2;
y0 = 680/2;
for i = 1:m,
  imgstmp{i}(2,:) = (imgs{i}(3,:)-x0);
  imgstmp{i}(3,:) = -(imgs{i}(2,:)-y0);
  imgstmp{i} = [ imgstmp{i}; ones(1, size(imgstmp{i},2))];
end;
imgs = imgstmp;

m = length(imgs);
M = gen_track_mat(imgs);
O = get_overlaps(M);
pair_mat = gen_pair_mat(O,10);
%[mot_affine1, new_imgs] = reconst_affine(imgs,pair_mat,0);
%[mot_affine1, new_imgs] = reconst_affine_last_equal_smooth(imgs,pair_mat,0);%
[mot_affine1, new_imgs] = reconst_affine_last_equal(imgs,pair_mat,0);%

str_affine = intersect_affine2(mot_affine1, new_imgs);
str_affine = [str_affine; ones(1, size(str_affine, 2))];

rec = get_err(new_imgs, mot_affine1, str_affine);mean(rec)

%[new_mot, new_str] = normalise_reconst(mot_affine1,str_affine);
new_mot = mot_affine1; new_str = str_affine;
[new_mot, new_str] = bundle_affine(new_imgs, new_mot, new_str, 3, 1e-3);
[new_mot, new_str] = nicify_affine(new_mot, new_str,1);
mot_eucl_mat = affine_to_eucl(new_mot,2000);

[mot_eucl, intr] = proj_mats_to_tuples(mot_eucl_mat);
plot_scene(mot_eucl, new_str, [2 3])

nb_pts_behind_cams(mot_mats(mot_eucl, intr), new_str, imgs)

[new_imgs, new_str] = select_pts_in_front(mot_mats(mot_eucl, intr), new_str, new_imgs);

intr_spec = zeros(size(intr));

[intr2, mot2, str2] = bundle_eucl(new_imgs, mot_eucl, intr, new_str, intr_spec, 2, 1e-3);

nb_pts_behind_cams(mot_mats(mot_eucl, intr), new_str, new_imgs)

intr3 = intr2; intr3(:,1) = mean(intr3(:,1)); 
intr3(:,2) = 1; intr3(:,3)=0;
intr_spec = zeros(size(intr_spec)); intr_spec(:,1) = 2;
[intr3, mot3, str3] = bundle_eucl(new_imgs, mot2, intr3, str2, intr_spec, 150, 5e-5);

i = 1; plot_scene(mot3, str3, [2 3], imgs{i}(1,:), i)


