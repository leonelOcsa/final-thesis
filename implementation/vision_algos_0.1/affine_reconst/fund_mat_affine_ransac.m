function [F, credibility] = fund_mat_affine_ransac(x1_large,x2_large)

n = size(x1_large,2);

err_old = inf;

nb_samples = 100;

fund_mat_rec = cell(nb_samples,1);
rec = zeros(nb_samples,n);

for i = 1:nb_samples,

%  keyboard
  randperm(n);
  test_comb = ans(1:4);

  x1 = x1_large(1:2, test_comb);
  x2 = x2_large(1:2, test_comb);

  [F, credibility] = fund_mat_affine(x1,x2);F =F/norm(F);

  rec(i,:) = diag(x1_large'*F*x2_large)';
  fund_mat_rec{i} = F;
end

outlier_score = mean(abs(rec));

thresh = median(outlier_score);

inliers = rec<thresh;

[slask, winner_idx] =max(sum(inliers,2));

%F = fund_mat_rec{winner_idx};
inlier_idx = find(inliers(winner_idx,:));
F = fund_mat_affine(x1_large(1:2,inlier_idx),x2_large(1:2,inlier_idx));
%keyboard
