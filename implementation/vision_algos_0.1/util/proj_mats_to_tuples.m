function [tuples, intrinsics] = proj_mats_to_tuples(eucl_mot)

m = length(eucl_mot);

tuples = cell(m,1);
intrinsics = zeros(m,5);

for i = 1:m,
  
  [k,r] = rq(eucl_mot{i});
  k = k/k(3,3);
  intrinsics(i,:) = [k(1,1) [k(2,2) k(1,2) k(1,3) k(2,3)]/k(1,1)];

  tuples{i} = cell(2,1); 
  tuples{i}{1} = rot_mat_to_exp_map(r);
  tuples{i}{2} = -r(1:3,1:3)'*r(:,4);
end




