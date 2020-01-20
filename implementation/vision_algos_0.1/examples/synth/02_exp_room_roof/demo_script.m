%
%Reconstruction of a square room with a roof
%The scene is randomly generated, might not work every time
%

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

%generate random room (4 walls, 1 roof), circular motion with 2 cameras
%placed off-circle
m = 24, n= 100, sm = 0, ss = 0, si = 0, sf = 0
[mot, str, mot_n0, imgs, intrt] = gen_mot_inside_room2(m,n,sm, ss, si, sf);
m = length(imgs)
i = m-2; plot_scene(mot,str, [2 3], imgs{i}(1,:),i)

%remove feature tracks that are too short:
[imgs,str] = remove_singles(imgs,3, str);

m = length(imgs);
M = gen_track_mat(imgs);
O = get_overlaps(M);
pair_mat = gen_pair_mat(O,10);%imagesc(pair_mat);
%reconstruct, normal:
%[mot_affine1, new_imgs] = reconst_affine(imgs,pair_mat,0);
%reconstruct, assuming first and last cameras are the same:
[mot_affine1, new_imgs] = reconst_affine_last_equal(imgs,pair_mat,0);%

str_affine = intersect_affine2(mot_affine1, new_imgs);
str_affine = [str_affine; ones(1, size(str_affine, 2))];

rec = get_err(new_imgs, mot_affine1, str_affine);mean(rec), hist(rec,30)

[new_mot, new_str] = normalise_reconst(mot_affine1,str_affine);
[new_mot, new_str] = bundle_affine(new_imgs, new_mot, new_str, 5, 1e-3);
[new_mot, new_str] = nicify_affine(new_mot, new_str,100);
mot_eucl_mat = affine_to_eucl(new_mot,100);

rec = get_err(new_imgs, mot_eucl_mat, new_str);mean(rec)

[mot_eucl, intr] = proj_mats_to_tuples(mot_eucl_mat);

plot_scene(mot_eucl, new_str, [1 2])


% get_err(new_imgs, mot_eucl_mat, new_str);mean(rec)

intr_spec = zeros(size(intr)); %intr_spec(:,1) = 2

[intr2, mot2, str2] = bundle_eucl(new_imgs, mot_eucl, intr, new_str, intr_spec, 2, 1e-3);
%plot_scene(mot2, str2, [1,2])

intr3 = intr2; intr3(:,1) = 100;%mean(intr3(:,1))/20; 
intr3(:,2) = 1; intr3(:,3)=0;
intr_spec = zeros(size(intr_spec));% intr_spec(:,1) = 2;
[intr3, mot3, str3] = bundle_eucl(new_imgs, mot2, intr3, str2, intr_spec, 10, 1e-1);

plot_scene(mot3, str3, [2 1], imgs{1}(1,:), 1)


[intr3, mot3, str3] = bundle_eucl(new_imgs, mot3, intr3, str3, intr_spec, 15, 1e-2);

plot_scene(mot3, str3, [2 1], imgs{1}(1,:), 1)

