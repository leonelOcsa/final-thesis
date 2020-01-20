% Copyright (C) 2001-2009 Nicolas Guilbert
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; If not, see <http://www.gnu.org/licenses/>.

%% [X_opt, err_old, lambda,Xvals] = optimise_fun(fun, Jfun, update_fun, args, X0, max_nb_iter, lambda0, tol)
%% a non-linear minimiser (Levenberg-Marquardt)
%%
%% return 
%% X_opt, 
%% err_old: 
%% lambda: vector containing the subsequent LM lambda values
%% Xvals: a matrix containing the 
%%
%% input parameters:
%%
%% fun: name of the function to be minimized
%% Jfun: name of the Jacobian of the function
%% update_fun: the update function
%% args: function parameters
%% X0: function variables
%% max_nb_iter: maximum number of minimisation steps
%% lambda0: initial lambda value
%% tol: tolerance (stopping criterion)


function [X_opt, err_old, lambda,Xvals] = optimise_fun(fun, Jfun, update_fun, args, X0, max_nb_iter, lambda0, tol)

  X_opt = X0;
  err_old = norm(feval(fun,X0,args))
  lambda = lambda0;
  ok_counter = 0;
  Xvals = X0;

for i = 1:max_nb_iter,

  J= feval(Jfun, X_opt, args,1000*eps);
  JtJ = J'*J;
  sizeJ = size(J,2);

  if issparse(J),
    damping_vec = ones(sizeJ,1);
    lambda_diag = lambda*sparse(1:sizeJ,1:sizeJ, damping_vec);
    d = spinv(JtJ+lambda_diag)*J'*feval(fun,X_opt,args);
  else
    d = inv(JtJ+lambda*eye(size(JtJ)))*J'*feval(fun,X_opt,args);
  end

  if ~isempty(update_fun), %if we need special update rules
    X_opt_tmp = feval(update_fun,{X_opt,d,args});
  else %if we can just use the usual LM-update
    X_opt_tmp = X_opt-d;
  end
  err_tmp = norm(feval(fun, X_opt_tmp, args));

if lambda >1e16, return, end

  if err_tmp <= err_old,
    de = norm(err_old-err_tmp);
    if de<tol, return, end
    err_old = err_tmp;
    ok_counter = ok_counter+1;
    X_opt = X_opt_tmp;
    Xvals = [Xvals, X_opt];
    [i, err_tmp,log10(de), lambda]
    if ok_counter >20,
      lambda = lambda/1.4;
      ok_counter = 0;
    end
  else
    lambda = 2*lambda;
    ok_counter = 0;
  end

end

