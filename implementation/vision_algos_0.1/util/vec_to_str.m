function str  = vec_to_str(strv)

  nb_str_params = 3;
  n = length(strv)/nb_str_params;
  str = reshape(strv,nb_str_params,n);
  str = [str; ones(1, size(str,2))];
