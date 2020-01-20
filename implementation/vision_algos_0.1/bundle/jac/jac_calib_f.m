function J = jac_calib_f(calib_f_vec, args, dummy)

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = args.mot;
  str = args.str;

nb_img_points =0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=zeros(nb_img_points*2,m);

  cur_J_row = 1;  

  for i = 1:m,

    K = [calib_f_vec(i) 0 0; 0 calib_f_vec(i) 0; 0 0 1];	
 
    pt_indices = imgs{i}(1,:);

    reproj = mot_to_proj_mat(mot{i})*str(:,pt_indices);

    reproj(1:2,:); reproj_xy_vec =ans(:);
    reproj_2z = kron(reproj(3,:)',[1 1]');
  
    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,i) =...
    -reproj_xy_vec(:,1)./reproj_2z;
    
    cur_J_row =  cur_J_row + 2*length(pt_indices);


end
