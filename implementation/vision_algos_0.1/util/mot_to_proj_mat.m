function P = mot_to_proj_mat(mot_tuple)
if length(mot_tuple{1})==4,
  P = quaternion_to_rmat(mot_tuple{1})*[eye(3), -mot_tuple{2}];
elseif length(mot_tuple{1})==3
  P = expm(skew_mat(mot_tuple{1}))*[eye(3), -mot_tuple{2}];
end
