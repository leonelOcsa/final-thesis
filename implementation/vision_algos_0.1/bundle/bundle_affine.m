function [new_mot, new_str]= bundle_affine(imgs, mot, str, nb_iter, lambda)

n = size(str,2);
m = length(mot);

motv = [];

for i = 1:m,
  mot_i = mot{i}(1:2, :);
  motv = [motv; mot_i(:)];
end

strv = str_to_vec(str);
paramv = [motv;strv];
args1.m = m;
args1.n = n;
args1.imgs = imgs;
%args1.mot = mot; not necessary, since motion info is provided in motveucl
%args1.str = str;

[paramv_opt, err, l, C_vals]=optimise_fun2( ...
                'err_affine_mot_str', ...
                'jac_affine_mot_str', ...
                'solve_affine_wrap', ...
                '', ...
                args1, ...
                paramv, ...
                nb_iter, lambda, 10*eps);

motv_opt = paramv_opt(1:length(motv));
strv_opt = paramv_opt(length(motv) + 1:end);

new_mot = mot;
for i = 1:m,
  new_mot{i} = [reshape(motv_opt((i-1)*8+1:i*8), 2,4); 0 0 0 1];
end

new_str = vec_to_str(strv_opt);

