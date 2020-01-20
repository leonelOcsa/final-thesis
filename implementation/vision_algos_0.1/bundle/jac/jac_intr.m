function J = jac_intr(intr_vec, args, dummy)
%function J = jac_intr(intr_vec, args, dummy)
  m = args.m;
  n = args.m;
  imgs = args.imgs;
  mot = args.mot;
  str = args.str;
  intrinsic_spec = args.intrinsic_spec;
  intrinsics = vec_to_intrinsics(intr_vec, args.intrinsics, intrinsic_spec);
  %[f a s x y], const, free, cam1->end
  %make one large matrix with derivatives of all intrinsic params:
  Jfull = [jac_focal(intrinsics(:,1), args),...
  jac_aspect(intrinsics(:,2),args),...
  jac_skew(intrinsics(:,3), args),...
  jac_xc(intrinsics(:,4), args),...
  jac_yc(intrinsics(:,5), args)];
  J = sparse(size(Jfull,1),0);
  for i = 1:5, %for each intrinsic param, create a matrix with derivs, and 
               %a matrix to "condense" columns for constant params
  C = mkchooser(intrinsic_spec(:,i));
  J = horzcat(J, sparse(Jfull(:,(i-1)*m+1:i*m)*C));
  end

