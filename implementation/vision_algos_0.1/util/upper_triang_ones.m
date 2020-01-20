function U = upper_triang_ones(n)

U = zeros(n);

for i = 1:n,
  U(i,:)=[zeros(1,i) ones(1,n-i)];
end
