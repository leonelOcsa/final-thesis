function J = jac_affine_mot_str(mot_str_vec,args,d)


nb_mot_params = 8;

m = args.m; n = args.n;

mot_vec = mot_str_vec(1:nb_mot_params*m);
str_vec = mot_str_vec(nb_mot_params*m+1:end);

new_args = struct();
new_args.m = args.m; %m
new_args.n = args.n; %n
new_args.imgs = args.imgs; %imgs

mot = cell(m,1);

for i = 1:m,
  mot{i} = [reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 2, 4); 0 0 0 1]; 
end
str = reshape(str_vec,3,length(str_vec)/3);
str = [str; ones(1,size(str,2))];

new_args.mot = mot;
new_args.str = str;


J = horzcat(jac_affine_mot(mot_vec, new_args, d),...
jac_affine_str(str_vec, new_args, d));

%J = jac_num('err_affine_mot_str',mot_str_vec,args,d);
