base_path  = '../../../'

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

m = 30, n= 300, sm = 0, ss = 0, si = 0, sf = 0

[mot, str, mot_n0, imgs, intrt] = gen_mot_box(m,n,sm, ss, si, sf);
%plot_scene(mot,str, [1 3])

%add noise:
%for i = 1:m, imgs{i}(2:3,:)+=randn(2,size(imgs{i},2));end
imgs = reduce_images_to_band(imgs, 80);%60 @ m = 30 images
imgs = remove_singles(imgs,2);
m = length(imgs);
M = gen_track_mat(imgs);
O = get_overlaps(M);
pair_mat = gen_pair_mat(O,10);%imagesc(pair_mat);
%[mot_affine1, new_imgs] = reconst_affine(imgs,pair_mat,0);
[mot_affine1, new_imgs] = reconst_affine_last_equal(imgs,pair_mat,0);%

str_affine = intersect_affine2(mot_affine1, new_imgs);
str_affine = [str_affine; ones(1, size(str_affine, 2))];

rec = get_err(new_imgs, mot_affine1, str_affine);mean(rec)

new_mot = mot_affine1; new_str = str_affine;
%[new_mot, new_str] = normalise_reconst(mot_affine1,str_affine);
[new_mot, new_str] = bundle_affine(new_imgs, new_mot, new_str, 5, 1e-3);
reca = get_err(new_imgs, new_mot, new_str);
%[mot_aff, mot_str] = bundle_affine(new_imgs, new_mot, new_str, 12, 1e-3);
for i = 1:3, [new_mot, new_str] = nicify_affine(new_mot, new_str,1);end
mot_eucl_mat = affine_to_eucl(new_mot,1000);

rec = get_err(new_imgs, mot_eucl_mat, new_str);mean(rec)
%
[mot_eucl, intr] = proj_mats_to_tuples(mot_eucl_mat);
plot_scene(mot_eucl, new_str, [1 3])

get_err(new_imgs, mot_eucl_mat, new_str);mean(rec)

intr_spec = zeros(size(intr));

[intr2, mot2, str2] = bundle_eucl(new_imgs, mot_eucl, intr, new_str, intr_spec, 2, 1e-3);

[new_imgs, str3] = select_pts_in_front(mot_mats(mot2,intr2), str2, new_imgs);

intr3 = intr2; intr3(:,1) = mean(intr3(:,1)); 
intr3(:,2) = 1; intr3(:,3)=0;
intr_spec = zeros(size(intr_spec)); intr_spec(:,1) = 2;
[intr3, mot3, str3] = bundle_eucl(new_imgs, mot2, intr3, str2, intr_spec, 150, 3e-4);

plot_scene(mot3, str3, [2 3])

