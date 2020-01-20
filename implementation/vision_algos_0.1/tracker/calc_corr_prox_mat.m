function C = calc_corr_prox_mat(patches1, patches2, O)

%function C = calc_corr_prox_mat(patches1, patches2, O)
%
%Calculates the correlation between the patches in patches1 and patches2
%patches1 and patches2 are cell structures containing matrices, all the
%matrices must have the same size.
%
%O indicates which combinations to calculate. If omitted, O=ones(l1,l2)
%where l1 and l2 are the lengthes of patches1 and patches2

l1 = length(patches1); l2 = length(patches2);

if nargin < 3, O = ones(l1,l2);end;

C = zeros(l1,l2);

for i = 1:l1,
%[i,l1]
  p1 = patches1{i};
  p1 = p1(:);
  for j=1:l2,
    p2 = patches2{j};
    if O(i,j)
      C(i,j) = corrcoef(p1, p2(:));
    else
      C(i,j) = -1;
    end
  end
end

