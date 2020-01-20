function J = jac_proj_str(str_vec, args, dummy)

  nb_mot_params = 12;
  m = args.m;
  n = args.n;
  imgs = args.imgs;
  proj_mot_vec = args.proj_mot_vec;
  str = vec_to_str(str_vec);

  proj_mot = cell(m,1);

  for i = 1:m,
    proj_mot{i} = reshape(proj_mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 4, 3)';
  end


  nb_img_points = 0;
  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=zeros(nb_img_points*2,n*3);

  cur_J_row = 1;  

  for i=1:m,

    pt_indices = imgs{i}(1,:);

    cur_P = proj_mot{i};
    reproj = cur_P*str(:, pt_indices);

    for j = 1:length(pt_indices),

      cur_idx = pt_indices(j);
      J(cur_J_row:cur_J_row+1, (cur_idx-1)*3+1:(cur_idx)*3) =...
       -(cur_P(1:2,1:3)*reproj(3,j) - reproj(1:2,j)*cur_P(3,1:3))/reproj(3,j)^2;

      cur_J_row = cur_J_row+2;
    end
  end
