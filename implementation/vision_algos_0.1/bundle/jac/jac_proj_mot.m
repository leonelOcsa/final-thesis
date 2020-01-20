function J = jac_proj_mot(mot_vec, args, dummy)

%function J = jac_proj_mot_only(mot_vec, args, dummy)
%dummy is used in numerical derivatives
  
  nb_mot_params =12;

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 4, 3)';
  end

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=zeros(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

  for i=1:m,

    pt_indices = imgs{i}(1,:);
    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,
       (i-1)*nb_mot_params+1:i*nb_mot_params) =...
	calc_sub_jacobian_proj(mot{i},str(:,pt_indices));
    
    cur_J_row =  cur_J_row + 2*length(pt_indices);

  end    
