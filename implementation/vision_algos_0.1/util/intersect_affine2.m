function [X,uncertainty] = intersect_affine2(mot, imgs)


if isempty(imgs), return ; end

m = length(mot);

all_idx_vec = [];
for i = 1:m,
tmp = imgs{i}(1,:)';
all_idx_vec = [all_idx_vec;tmp];
end

all_idx_vec = sort(unique(all_idx_vec'));
max_idx = max(all_idx_vec);
min_idx = min(all_idx_vec);

mX = zeros(3,max_idx-min_idx+1);
X = [];
uncertainty = [];

for i = all_idx_vec,
[i, max(all_idx_vec)]
A = [];
b = [];

  for j = 1:m,

  idx = find(imgs{j}(1,:)==i);
  if ~isempty(idx),
    tmp = mot{j}(1:2,1:3);
    A = [A;tmp];

    tmp = -mot{j}(1:2,4)+imgs{j}(2:3,idx);
    b = [b; tmp];

   end
  end

  if size(A,1)>2,
    X = [X,A\b];
    [u,d,v] = svd(A);
    uncertainty = [uncertainty, d(1,1)/d(3,3)];

  else
    X = [X,[NaN NaN NaN]'];
    uncertainty = [uncertainty,inf];

  end

end

