function [new_mot, new_str] = normalise_reconst(mot, str)

m = length(mot);
mX = -mean(str(1:3, :),2);
[a,b,c] = svd(str(1:3,:)-mX*ones(1,size(str,2)));
binv = diag(diag(b).^-1); 
T = eye(4); T(1:3,1:3) = (binv'*a'); 
%T(1:3, 4)= -mX;
Tinv = inv(T); 
new_str = T*str;
new_mot = mot;
for i=1:m,
  new_mot{i} = mot{i}*Tinv;
end;

