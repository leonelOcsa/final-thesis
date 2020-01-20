function [X_opt, err_old, lambda,Xvals] = optimise_fun2(fun, Jfun, solve_fun, update_fun, args, X0, max_nb_iter, lambda0, tol)
%function [X_opt, err_old, lambda,Xvals] = optimise_fun(fun, Jfun, solve_fun, update_fun, args, X0, max_nb_iter, lambda0, tol)
  X_opt = X0;
  err_old = norm(feval(fun,X0,args))
  lambda = lambda0;
  ok_counter = 0;
  Xvals = X0;
  nb_iter = 0;
  done = 0;
while(~done),
  J= feval(Jfun, X_opt, args,1000*eps);
%keyboard
%J2 = jac_num(fun, X_opt, args, 100*eps);
  sizeJ = size(J,2);
  %D = sparse(1:sizeJ, 1:sizeJ,diag(JtJ).^-0.5);
  %J2 = J*D;
  %JtJ2 = J2'*J2;
%keyboard
  if isempty(solve_fun)
    JtJ = J'*J;
    if issparse(J),%default solving of the LM-step, i.e. uniform damping
      damping_vec = ones(sizeJ,1);

      lambda_diag = lambda*sparse(1:sizeJ,1:sizeJ, damping_vec);
      d = spinv(JtJ+lambda_diag)*J'*feval(fun,X_opt,args);
    else
      d = inv(JtJ+lambda*eye(size(JtJ)))*J'*feval(fun,X_opt,args);
    end
  else
%    keyboard
    err = feval(fun, X_opt, args);
    d = feval(solve_fun, err, J, args, lambda);

  end
   %d = spinv(D)*d;
  if ~isempty(update_fun), %if we need special update rules
%  keyboard
    X_opt_tmp = feval(update_fun,{X_opt,d,args});
  else %if we can just use the usual LM-update
  X_opt_tmp = X_opt-d;
  end
  err_tmp = norm(feval(fun, X_opt_tmp, args))

%  keyboard

  if lambda > 1e16, done = 1; end
  if err_tmp < 1e-11, done = 1; end

 if err_tmp <= err_old,
    de = norm(err_old-err_tmp);
    if de<tol, return, end
    err_old= err_tmp;
    ok_counter =ok_counter+1;
    X_opt = X_opt_tmp;
    nb_iter = nb_iter + 1; 
    if nb_iter>=max_nb_iter, done = 1; end
    Xvals = [Xvals, X_opt];
    [nb_iter, err_tmp,log10(de), lambda]
    if ok_counter >3,%20
      lambda=lambda/1.5; %1.4
      ok_counter = 0;
    end
  else
    lambda = 2*lambda;
    ok_counter = 0;
  end
end

