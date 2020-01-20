function d = solve_mot_str_bsp(err, J, args)

%function d = solve_mot_str_bsp(err, J)
%block sparse solver for motion and structure
%case 1 or 2: is mot-block larger than str-block?
%[A  C
% C' B]
%A: block1
%B: block2
%C: block3

m = args.m;
n = args.n;
nmp = args.nmp; %number of motion parameters,
lambda = args.lambda;

if isfield(args, 'intrinsic_spec'),
  nb_intr = nb_intrinsic_vars(args.intrinsic_spec);
else
  nb_intr = 0;
end
mark1 = nb_intr;
mark2 = nb_intr+nmp*m;

%reg = sparse( (1:size(J,2))', (1:size(J,2))', (sum(J.^2).^-.5)');
reg = sparse( (1:size(J,2))', (1:size(J,2))', ((ones(1,size(J,1))*(J.^2)).^-.5)');
J = J*reg;

JtJ = J'*J;
A = JtJ(1:mark2, 1:mark2);
B = JtJ(mark2+1:size(JtJ,1), mark2+1:size(JtJ,2));
C = JtJ(1:mark2, mark2+1:size(JtJ,2));
J'*err;
Em = ans(1:mark2); %Jac^T * motion error vector
Es = ans(mark2+1:end); %Jac^T * structure error vector
clear J;
clear JtJ;%could use a lot of memory

%assuming nmp motion parameters

if nmp*m+nb_intr > 3*n, %case 1: solving for mot first

%build A_inv
A_inv = zeros(nmp*nmp*m,3); %sparse matrix format
%invert block1 and calculate Em entries in same for-loop
  nmp2 = nmp*nmp;
  for i = 1:m,

    tmp_JtJ_block = A(mark1+((i-1)*nmp+1:i*nmp), mark1+((i-1)*nmp+1:i*nmp)) ;
    tmp_JtJ_inv_block = inv(tmp_JtJ_block+ lambda*eye(nmp));
    A_inv(nmp2*(i-1)+1:nmp2*i, 1) =  kron(ones(nmp,1), ((i-1)*nmp+1:i*nmp)');
    A_inv(nmp2*(i-1)+1:nmp2*i, 2) =  kron(((i-1)*nmp+1:i*nmp)', ones(nmp,1));
    A_inv(nmp2*(i-1)+1:nmp2*i, 3) =  tmp_JtJ_inv_block(:);
  end

 %adding inverse of intrinsic block to A (upper left):
  A_inv(:,[1 2]) = A_inv(:,[1 2]) + nb_intr;
  tmp_JtJ_inv_block = inv(A(1:mark1, 1:mark1)+lambda*eye(nb_intr));
  [tmpidx1,tmpidx2,tmpvals] = spfind(sparse(tmp_JtJ_inv_block));
  A_inv = sparse([tmpidx1; A_inv(:,1)], ...
                 [tmpidx2; A_inv(:,2)], ...
                 [tmpvals; A_inv(:,3)]);
  B = B + lambda*eye(size(B));
  if n>0
    ds = (B-C'*A_inv*C) \ (Es-C'*A_inv*Em);
    dm = A_inv*(Em - C*ds);
    d = [dm;ds];
 else
   d = A_inv*Em;
 end

else %case2: solving for str first

B_inv = zeros(3*3*n,3); %will become a sparse matrix
  for i = 1:n,

    tmp_JtJ_block = B((i-1)*3+1:i*3, (i-1)*3+1:i*3) ;
    tmp_JtJ_inv_block = inv(tmp_JtJ_block+ lambda*eye(3));
    B_inv(3*3*(i-1)+1:3*3*i, 1) =  kron(ones(3,1), ((i-1)*3+1:i*3)');
    B_inv(3*3*(i-1)+1:3*3*i, 2) =  kron(((i-1)*3+1:i*3)', ones(3,1));
    B_inv(3*3*(i-1)+1:3*3*i, 3) =  tmp_JtJ_inv_block(:);
  end
%keyboard
  B_inv = sparse(B_inv(:,1), B_inv(:,2), B_inv(:,3));
  A = A+lambda*eye(size(A));
%  A = A + lambda*diag([.001*ones(1,nb_intr) ones(1,size(A,1)-nb_intr)]);

  if m>0,
    dm = (A-C*B_inv*C') \ (Em-C*B_inv*Es);
    ds = B_inv*(Es - C'*dm);
    d = [dm;ds];
  else
    d = B_inv*Es;
  end

end

d = reg*d;
