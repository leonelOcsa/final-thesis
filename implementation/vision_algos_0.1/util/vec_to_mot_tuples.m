function tup = vec_to_mot_tuples(mot_vec,parameterisation)

nb_rot_params = parameterisation{1};
nb_total_params = parameterisation{2};

n = length(mot_vec)/nb_total_params;
tup = cell(n,1);

cur_idx = 1;

for i = 1:n,
  tup{i} = {mot_vec(cur_idx:cur_idx+nb_rot_params-1),
	    mot_vec(cur_idx+nb_rot_params:cur_idx+nb_total_params-1)};
  cur_idx = cur_idx + nb_total_params;
end
