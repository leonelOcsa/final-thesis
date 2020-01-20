function J = jac_str_bsp(str_vec, args, dummy)

%  m = args{1};
%  n = args{2};
%  imgs = args{3};
%  mot = args{4};
%  str = vec_to_str(str_vec);

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = mot_mats(args.mot, args.intrinsics);
  str = vec_to_str(str_vec);
  nb_str_params = 3;


  nb_img_points = 0;
  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  Js=zeros(nb_img_points*2*nb_str_params,3);%,n*nb_str_params); %sparse format

  cur_J_row = 0;  
  
  for i=1:m,
    pt_indices = imgs{i}(1,:);

    cur_P = mot{i};
    reproj = cur_P*str(:, pt_indices);

    for j = 1:length(pt_indices),

      cur_idx = pt_indices(j);
      %J( cur_J_row:cur_J_row+1,...
       %  (cur_idx-1)*nb_str_params+1:(cur_idx)*nb_str_params) =...
     
     blk = -(cur_P(1:2,1:nb_str_params)*reproj(3,j) - ...
              reproj(1:2,j)*cur_P(3,1:nb_str_params))/reproj(3,j)^2;

      Js(cur_J_row+1:cur_J_row+6, 1) = kron([1 1 1]', cur_J_row/3 +[1 2]');
      Js(cur_J_row+1:cur_J_row+6, 2) = ...
              kron(nb_str_params*(cur_idx-1) + [1 2 3]', [1 1]');
      Js(cur_J_row+1:cur_J_row+6, 3) = blk(:);

     cur_J_row = cur_J_row + 6;
  end
    
  end    

  J = sparse(Js(:,1), Js(:,2), Js(:,3), nb_img_points*2, n*nb_str_params, size(Js,1));
%keyboard
