function err = err_affine_mot(mot_vec, args, dummy)

  nb_mot_params =8;

%keyboard
  m = args{1};
  n = args{2};
  imgs = args{3};
  str = args{5};

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = [reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 2, 4); 0 0 0 1]; 
  end

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end

err=[];
for i=1:m,

  pt_indices = imgs{i}(1,:);
  imgs{i}(2:4,:)-mot{i}*str(:, pt_indices); ans(1:2,:);
    
  err = [err; ans(:)];
    
end    
