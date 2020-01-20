function err = err_affine_simple(mot_vec, args)

 m = args{1};
 n = args{2};
 imgs = args{3};

 mot = cell()
 for i = 1:m,
