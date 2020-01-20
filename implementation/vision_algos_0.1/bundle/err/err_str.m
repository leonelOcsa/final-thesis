function err = err_str(str_vec, args)

%  m = args{1};
%  n = args{2};
%  imgs = args{3};
%  mot = args{4} ;
%  focals = args{6};

  nb_str_params = 3;

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = args.mot ;
  str = vec_to_str(str_vec); 
  focals = args.focals;
  
  err=[];


  
  for i=1:m,

    pt_indices = imgs{i}(1,:);

    K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];

    cur_P = mot_to_proj_mat(mot{i});
    reproj = pflat(K*cur_P*str(:, pt_indices));

    imgs{i}(2:4,:)-reproj; ans(1:2,:);
    err = [err; ans(:)];
    
  end    
