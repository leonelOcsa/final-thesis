function err = err_mot_str(mot_str_vec, args)

%  m = args{1};
%  n = args{2};
%  imgs = args{3};
%  focals = args{6}

  nb_total_params = args.parameterisation{2};
  nb_rot_params = args.parameterisation{1};

  m = args.m;
  n = args.n;
  imgs = args.imgs;

  focals = args.focals;	
  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:length(mot_str_vec));


  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;

%  keyboard
  str = vec_to_str(str_vec);

  err=[];
  
  for i=1:m,

%keyboard 

   pt_indices = imgs{i}(1,:);

   K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];

   imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];
  end    
  
