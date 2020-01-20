function d = solve_eucl_wrap(err, J, args, lambda)

args2.m = args.m;
args2.n = args.n;
args2.lambda = lambda;
args2.nmp = 6;
args2.intrinsic_spec = args.intrinsic_spec;
d = solve_mot_str_bsp(err, J, args2);
