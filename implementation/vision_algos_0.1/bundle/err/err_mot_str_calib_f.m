function err = err_mot_str_calib_f(cal_mot_str_vec, args)


  m = args.m;
  n = args.n;
  imgs = args.imgs;
  
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};

  %assuming variable focal length only:
  %(todo: other intern params, given through args)
  
  mark1 = m; %marks end of intrinsic params
  mark2 = m+nb_total_params*m; %marks end of all cam params

  cal_vec = cal_mot_str_vec(1:mark1);
  mot_vec = cal_mot_str_vec(mark1+1:mark2);
  str_vec = cal_mot_str_vec(mark2+1:end);

  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;
  str = vec_to_str(str_vec);

  err = [];

  for i=1:m,
   
    K = [cal_vec(i) 0 0; 0 cal_vec(i) 0; 0 0 1];

    pt_indices = imgs{i}(1,:);

    imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];

  end    
