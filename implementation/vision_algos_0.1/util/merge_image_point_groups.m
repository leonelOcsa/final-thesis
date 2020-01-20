function x = merge_image_point_groups(x1,x2)

if isempty(x1), x = x2; return; end
if isempty(x2), x = x1; return; end

indices = union(x1(1,:), x2(1,:));
x = zeros(4,length(indices));

for i = 1:length(indices),
  idx1 = find(x1(1,:)==indices(i));
  if ~isempty(idx1),
    x(:,i) = x1(:,idx1);
  else
    idx2 = find(x2(1,:)==indices(i));
    x(:,i) = x2(:,idx2);
  end
end
