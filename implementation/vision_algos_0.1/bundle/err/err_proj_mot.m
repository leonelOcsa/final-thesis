function err = err_proj_mot(proj_mot_vec, args)

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;

  nb_mot_params = 12;

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = reshape(proj_mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 4, 3)';
  end

  err=[];

  for i=1:m,

    pt_indices = imgs{i}(1,:);

    imgs{i}(2:4,:)-pflat(mot{i}*str(:, pt_indices)); ans(1:2,:);
    err = [err; ans(:)];
  end
