function J = jac_eucl_bsp(calib_mot_str_vec, args, d)

  m = args.m;
  n = args.m;
  imgs = args.imgs;
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};
  intrinsics = args.intrinsics;
  intr_spec = args.intrinsic_spec;
  nb_intr = nb_intrinsic_vars(intr_spec);
  calibv = calib_mot_str_vec(1:nb_intr);

  mot_str_vec = calib_mot_str_vec(nb_intr+1:end);
  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:end);
  args_new = args;
  args_new.intrinsics = vec_to_intrinsics(calibv, intrinsics, intr_spec);
  args_new.mot =vec_to_mot_tuples(mot_vec, args.parameterisation);
  args_new.str = vec_to_str(str_vec);

  Jm = jac_mot_bsp(mot_vec, args_new,d);
  Js = jac_str_bsp(str_vec, args_new, d);
  J_intr = jac_intr(calibv, args_new, d);
  J = horzcat(horzcat(J_intr, Jm), Js);

