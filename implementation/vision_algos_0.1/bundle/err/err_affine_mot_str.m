function err = err_affine_mot_str(affine_mot_str_vec, args)

m = args.m;
imgs = args.imgs;

nb_mot_params = 8;
mot_vec = affine_mot_str_vec(1:nb_mot_params*m);
str_vec = affine_mot_str_vec(nb_mot_params*m+1:end);

mot = cell(m,1);
%keyboard
for i = 1:m,
  mot{i} = [reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 2, 4); 0 0 0 1];
end

str = reshape(str_vec,3,length(str_vec)/3);
str = [str; ones(1, size(str,2))];

err=[];
%  keyboard
for i=1:m,

  pt_indices = imgs{i}(1,:);

  imgs{i}(2:4,:)-mot{i}*str(:, pt_indices); ans(1:2,:);
    
  err = [err; ans(:)];
    
end    
