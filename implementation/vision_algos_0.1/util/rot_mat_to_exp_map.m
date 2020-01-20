function v = rot_mat_to_exp_map(R)

real(logm(R(1:3,1:3))); v = [-ans(2,3), ans(1,3), -ans(1,2)]';

