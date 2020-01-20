function err = err_affine_str(str_vec, args)

  nb_mot_params =8;

%keyboard
  m = args{1};
  n = args{2};
  imgs = args{3};
  mot = args{4};
%  str = args{5};

  str = reshape(str_vec,3,length(str_vec)/3);
  str = [str;ones(1,size(str,2))];
  

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

  J=zeros(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

err=[];
for i=1:m,

  pt_indices = imgs{i}(1,:);
  imgs{i}(2:4,:)-mot{i}*str(:, pt_indices); ans(1:2,:);
    
  err = [err; ans(:)];
    
end    
