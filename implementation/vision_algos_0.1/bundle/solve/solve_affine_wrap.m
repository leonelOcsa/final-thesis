function d = solve_affine_wrap(err, J, args, lambda)

args2.m = args.m;
args2.n = args.n;
args2.lambda = lambda;
args2.nmp = 8;
d = solve_mot_str_bsp(err, J, args2);
