function J = jac_mot_bsp(mot_vec, args, dummy)

%function J = jac_mot_only(mot_str_vec, args, dummy)
%dummy is used in numerical derivatives
  
  nb_mot_params =6;

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;

  intr = args.intrinsics;
%keyboard
mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=sparse(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

  for i=1:m,

    pt_indices = imgs{i}(1,:);
%  keyboard

   f = intr(i,1);
   K = [f f*intr(i,3) f*intr(i,4);
        0 f*intr(i,2) f*intr(i,5);
	0 0         1];

	
	blk = calc_sub_jacobian_proj( K*mot_to_proj_mat(mot{i}),str(:,pt_indices))*calc_jac_proj2eucl(mot{i}, intr(i,:));  

%    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,
%       (i-1)*nb_mot_params+1:i*nb_mot_params) =ans;
  
  J = spinsert(J, blk, cur_J_row, (i-1)*nb_mot_params+1);

  cur_J_row =  cur_J_row + 2*length(pt_indices);

  end

