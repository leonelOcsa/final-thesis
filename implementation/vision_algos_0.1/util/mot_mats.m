function mot = mot_mats(mot_eucl, intrinsics)

%function mot = mot_mats(mot_eucl, intrinsics)

m = length(mot_eucl);
mot = cell(m,1);

for i = 1:m,
  cal_vec = intrinsics(i,:); f = cal_vec(1);

  K = [f f*cal_vec(3) f*cal_vec(4); 
         0          f*cal_vec(2) f*cal_vec(5);
         0          0                     1];

  mot{i} = K*mot_to_proj_mat(mot_eucl{i});
end

