function J = jac_mot(mot_vec, args, dummy)

%function J = jac_mot_only(mot_str_vec, args, dummy)
%dummy is used in numerical derivatives
  
  nb_mot_params =6;

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;

  focals = args.focals;
%keyboard
mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=zeros(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

  for i=1:m,

    pt_indices = imgs{i}(1,:);
%  keyboard

	
	calc_sub_jacobian_proj( mot_to_proj_mat(mot{i}),str(:,pt_indices))*calc_jac_proj2eucl(mot{i}, focals(i));

    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,
       (i-1)*nb_mot_params+1:i*nb_mot_params) =ans;
%  ans([1 2 3 10 4 5 6 11 7 8 9 12], :);
   
    cur_J_row =  cur_J_row + 2*length(pt_indices);

  end    
