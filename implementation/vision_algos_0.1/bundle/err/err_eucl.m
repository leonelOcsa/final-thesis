function err = err_eucl(cal_mot_str_vec, args)

%assumes all f independent and free to vary 
  m = args.m;
  n = args.n;
  imgs = args.imgs;
%  penalty_coeff = args.penalty_coeff; 
  intrinsic_spec = args.intrinsic_spec;
  given_intrinsics = args.intrinsics;
  nb_intr = nb_intrinsic_vars(intrinsic_spec);
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};
  %assuming variable focal length only:
  %(todo: other intern params, given through args)
  mark1 = nb_intr; %marks end of intrinsic params
  mark2 = nb_intr+nb_total_params*m; %marks end of all cam params
%  keyboard
  cal_vec = cal_mot_str_vec(1:mark1);
  mot_vec = cal_mot_str_vec(mark1+1:mark2);
  str_vec = cal_mot_str_vec(mark2+1:end);
  intr = vec_to_intrinsics(cal_vec, given_intrinsics, intrinsic_spec);
  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;
  str = vec_to_str(str_vec);
  err = [];


  for i=1:m,
  
  f = intr(i,1);
  
    K = [f f*intr(i,3) f*intr(i,4); 
         0          f*intr(i,2) f*intr(i,5);
         0          0                     1];
    pt_indices = imgs{i}(1,:);
    imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];
  end   

