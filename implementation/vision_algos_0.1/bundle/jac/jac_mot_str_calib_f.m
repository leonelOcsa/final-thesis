function J = jac_mot_str_calib_f(calib_mot_str_vec, args, d)


  m = args.m;
  n = args.m;
  imgs = args.imgs;
  
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};

  mot_str_vec = calib_mot_str_vec(m+1:end);
  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:end);
  calibv = calib_mot_str_vec(1:m);

  args_new = args;
  args_new.focals = calibv;
  args_new.mot = vec_to_mot_tuples(mot_vec, args.parameterisation);
  args_new.str = vec_to_str(str_vec);

  Jm = jac_mot(mot_vec, args_new,d);
  Js = jac_str(str_vec, args_new, d);

  Jcalib_f = jac_calib_f(calibv, args_new, d);

  J = [Jcalib_f, Jm, Js];
