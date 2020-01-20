
function J = calc_jac_proj2eucl(mot_tuple, intrinsics)
f = intrinsics(1);
K = [f, f*intrinsics(3), f*intrinsics(4);
     0, f*intrinsics(2), f*intrinsics(5);
     0              , 0           , 1];
B1 = skew_mat([1 0 0]); 
B2 = skew_mat([0 1 0]); 
B3 = skew_mat([0 0 1]); 
T = mot_tuple{2};
R = expm(skew_mat(mot_tuple{1}));
dR1 = K*B1*R;
dR2 = K*B2*R;
dR3 = K*B3*R;
%keyboard
 J =[dR1(:), dR2(:), dR3(:) ,zeros(9,3);[-dR1*T, -dR2*T, -dR3*T, ], -K*R];
  J = J([1 4 7 10 2 5 8 11 3 6 9 12], :);

