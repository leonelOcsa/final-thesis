function [F,credibility] = fund_mat_affine(x1,x2)

n = size(x1,2);

S = [x1(1:2,:)', x2(1:2,:)'];
ms = mean(S);
S = S-ones(n,1)*ms;
S = ((sum((S.^2),2).^-.5)*[1 1 1 1]).*S;

[a,b,c] = svd(S'*S);
f = c(:,4);

F = [0 0 f(1); 0 0 f(2); f(3) f(4) -f'*ms'];

F = F/norm(F);
credibility = b(3,3)/b(4,4);
%keyboard

