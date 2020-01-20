function [X,uncertainty] = intersect_proj(mot, imgs)


if isempty(imgs), return ; end

m = length(mot);

Ab_systems = cell(m,2);
for i = 1:m,
  Ab_systems(i,1) = [];
  Ab_systems(i,2) = [];
end

all_idx_vec = [];
for i = 1:m,
all_idx_vec = [all_idx_vec;imgs{i}(1,:)'];
end
all_idx_vec = sort(unique(all_idx_vec));
max_idx = max(all_idx_vec);
min_idx = min(all_idx_vec);

mX = zeros(3,max_idx-min_idx+1);
X = [];
uncertainty = [];
%credibility = zeros(1,max_idx);

for i = all_idx_vec,

A1 = [];
A2 = [];

  for j = 1:m,

  idx = find(imgs{j}(1,:)==i);
  if idx ~=[],

    A1 = [A1; (imgs{j}(2:4, idx))(:)];
    A2 = [A2; mot{j}];

   end
  end
 
  A = [diag(A1)*kron(eye(length(A1)/3),[1 1 1]'), A2];
  
  if size(A,1)>2,
%    if i == 1600 || i ==100,keyboard,end
    [u,d,v] = svd(A);
    X = [X,pflat(v(end-3:end, end))]; 

  else
    X = [X,[NaN NaN NaN]'];
  end

end



%[skew_mat(imgs{1}(2:4,6))* mot{1};skew_mat(imgs{2}(2:4,6))* mot{2};skew_mat(imgs{3}(2:4,6))* mot{3}]
%[a,b2,c] = svd(ans); b(4,4)
%[a,b2,c] = svd([A, -b]), b2
