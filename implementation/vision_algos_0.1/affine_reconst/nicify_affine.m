function [new_mot, new_str, H] = nicify_affine(mot,str,regul_f)

%function [new_mot, new_str] = nicify_affine(mot,str,regul_f)
%
%regularise the affine camera matrices in mot, so that skew gets close
%to 0, aspect ratio close to 1 and optionally f close to regul_f

m = length(mot);
A = [];
B = [];
for i = 1:m,
  tmp = mot{i}(1:2,1:3); A = [A; tmp];
  [k,r] = rq2(mot{i}(1:2,1:3));
  if regul_f,
    B = [B; eye(2)*regul_f*r];
  else
    B =[B; (eye(2)*k(1,1)*r)];
  end
end
H = A\B;
H = [H,[0 0 0]'; 0 0 0 1];
new_mot = mot;
for i = 1:m,
  new_mot{i} = new_mot{i}*H;
end
new_str = inv(H)*str;

