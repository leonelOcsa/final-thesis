function J = jac_proj_mot_str(proj_mot_str_vec, args, dummy)

%uses jac_mot_only_num3

nb_total_params = 12;

m = args.m; n = args.n;

proj_mot_vec = proj_mot_str_vec(1:nb_total_params*m);
str_vec = proj_mot_str_vec(nb_total_params*m+1:end);

proj_args = struct();
proj_args.m = args.m; %m
proj_args.n = args.m; %n
proj_args.imgs = args.imgs; %imgs
proj_args.proj_mot_vec = proj_mot_vec;
proj_args.str = vec_to_str(str_vec);

J = [jac_proj_mot(proj_mot_vec, proj_args, dummy),...
jac_proj_str(str_vec, proj_args, dummy)];
