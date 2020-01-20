function [new_intrinsics, new_mot, new_str]= bundle_eucl(imgs, mot, intrinsics, str, intrinsic_spec, nb_iter, lambda)

%function [new_intrinsics, new_mot, new_str]= bundle_eucl(imgs, 
%mot, intrinsics, str, intrinsic_spec, nb_iter, lambda)



n = size(str,2);
m = length(mot);
intrv = intrinsics_to_vec(intrinsics, intrinsic_spec);
motveucl = mot_to_vec_eucl(mot);
strv = str_to_vec(str);
paramv = [intrv; motveucl; strv];
args1.m = m;
args1.n = n;
args1.imgs = imgs;
%args1.mot = mot; not necessary, since motion info is provided in motveucl
%args1.str = str;
args1.intrinsics = intrinsics; %intrinsic parameters, some are needed
args1.intrinsic_spec = intrinsic_spec;%spec (const, free, absent)
args1.parameterisation = {3,6};%parameterisation,{nb_rot_params,nb_total_params}

[paramv_opt, err, l, C_vals]=optimise_fun2( ...
                'err_eucl', ...
                'jac_eucl_bsp', ...
                'solve_eucl_wrap', ...
                'update_eucl', ...
                args1, ...
                paramv, ...
                nb_iter, lambda, 1e6*eps);
mark1 = length(intrv);
mark2 = mark1 + length(motveucl);
intrv_opt = paramv_opt(1:mark1);
motv_opt = paramv_opt(mark1+1:mark2);
strv_opt = paramv_opt(mark2+1:end);
new_mot = vec_to_mot_tuples(motv_opt, args1.parameterisation);
new_str = vec_to_str(strv_opt);
new_intrinsics = vec_to_intrinsics(intrv_opt, intrinsics, intrinsic_spec);

