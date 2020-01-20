function err = err_proj_mot_str(proj_mot_str_vec, args)

  nb_total_params = 12;
  m = args.m;
  n = args.n;
  imgs = args.imgs;

  proj_mot_vec = proj_mot_str_vec(1:nb_total_params*m);
  str_vec = proj_mot_str_vec(nb_total_params*m+1:end);


  mot = cell(m,1);

  for i = 1:m,
    mot{i} = reshape(proj_mot_vec((i-1)*nb_total_params+1:i*nb_total_params), 4, 3)';
  end

  str = vec_to_str(str_vec);
  err=[];

  for i=1:m,


   pt_indices = imgs{i}(1,:);

   imgs{i}(2:4,:)-pflat(mot{i}*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];
  end    
  
