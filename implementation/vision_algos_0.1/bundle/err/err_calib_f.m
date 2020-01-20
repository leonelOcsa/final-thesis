function err = err_calib_f(calib_vec, args)

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = args.mot;
  str = args.str;
  
  err=[];
  
  for i=1:m,

    pt_indices = imgs{i}(1,:);

    K = [calib_vec(i) 0 0; 0 calib_vec(i) 0; 0 0 1];

    imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:, pt_indices)); ans(1:2,:);
    
    err = [err; ans(:)];
    
  end    
