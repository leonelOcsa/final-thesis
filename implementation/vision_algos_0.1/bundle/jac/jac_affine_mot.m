function J = jac_affine_mot(mot_vec, args, d)

%keyboard

  nb_mot_params =8;

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = [reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 2, 4); 0 0 0 1]; 
  end

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

%  J=zeros(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

  J = [];

  for i=1:m,

    pt_indices = imgs{i}(1,:);
%  keyboard

  -[kron(str(:,pt_indices)',[1 0]'), kron(str(:,pt_indices)',[0 1]')];
  subJ=ans(:,[1 5 2 6 3 7 4 8]);  %reordering required
  
%    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,
%       (i-1)*nb_mot_params+1:i*nb_mot_params) =...
%	  subJ;
    
    subJvidx = (cur_J_row:cur_J_row+2*length(pt_indices)-1)';
    subJhidx = ((i-1)*nb_mot_params+1:i*nb_mot_params)';

    [subJh, subJw] = size(subJ);

    J = [J; 
    kron(ones(subJw,1),subJvidx),kron(subJhidx,ones(subJh,1)),subJ(:)];

    cur_J_row =  cur_J_row + 2*length(pt_indices);

  end    

%keyboard
J = sparse(J(:,1), J(:,2), J(:,3),nb_img_points*2,m*nb_mot_params);
%J = jac_num('err_affine_mot',mot_vec,args,d);
