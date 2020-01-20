function x = lap(C)

c = C(:)';
%A = [ kron(eye(size(C,2)), ones(1, size(C,1))); 
%      kron(ones(1,size(C,2)), eye(size(C,1)))];
%b = ones(size(A,1),1);
lap_solve_format('tmp_lp', c, size(C,1),size(C,2));% A, b);
system('/usr/bin/lp_solve <tmp_lp >tmp_out');
x = lp_solve_parse('tmp_out',size(c,2));
system('rm tmp_lp tmp_out');
x = reshape(x, size(C,1), size(C,2));

