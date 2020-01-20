function O = get_overlaps(M)


m = size(M,1);
O = zeros();

%for i = 1:m,
%  for j = 1:m,
%    O(i,j)=sum(M(i,:).*M(j,:)>0);
%  end
%end

O = M*M';
