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

%% J = jac_mot_str(mot_str_vec, args, dummy)
%% return [dP/dmot, dP/dstr] i.e. the jacobian of the projective camera parameters
%% wrt. to motion and structure parameters

function J = jac_mot_str(mot_str_vec, args, dummy)

  nb_total_params = args.parameterisation{2};

  m = args.m; n = args.n;

  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:end);

  new_args = args;

  new_args.mot = vec_to_mot_tuples(mot_vec, args.parameterisation);
  new_args.str = vec_to_str(str_vec);

  J = [jac_mot(mot_vec, new_args, dummy), jac_str(str_vec, new_args, dummy)];

endfunction