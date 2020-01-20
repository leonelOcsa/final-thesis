function J = jac_mot_str(mot_str_vec, args, dummy)

%uses jac_mot_only_num3

nb_total_params = args.parameterisation{2};

m = args.m; n = args.n;

mot_vec = mot_str_vec(1:nb_total_params*m);
str_vec = mot_str_vec(nb_total_params*m+1:end);

new_args = args;
%new_args{1} = args{1}; %m
%new_args{2} = args{2}; %n
%new_args{3} = args{3}; %imgs

new_args.mot = vec_to_mot_tuples(mot_vec, args.parameterisation);
new_args.str = vec_to_str(str_vec);
%new_args{6} = args{6}; %focals

%keyboard
J = [jac_mot(mot_vec, new_args, dummy),...
jac_str(str_vec, new_args, dummy)];
