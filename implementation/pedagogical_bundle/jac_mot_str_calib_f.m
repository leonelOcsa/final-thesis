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

%% J = jac_mot_str_calib_f(calib_mot_str_vec, args, d)
%% return [dP/f_calib, dP/dmot, dP/dstr] i.e. the jacobian of the projective 
%% camera parameters wrt. the focal length, motion parameters and structure
%% parameters

function J = jac_mot_str_calib_f(calib_mot_str_vec, args, d)


  m = args.m;
  n = args.m;
  imgs = args.imgs;
  
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};

  mot_str_vec = calib_mot_str_vec(m+1:end);
  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:end);
  calibv = calib_mot_str_vec(1:m);

  args_new = args;
  args_new.focals = calibv;
  args_new.mot = vec_to_mot_tuples(mot_vec, args.parameterisation);
  args_new.str = vec_to_str(str_vec);

  Jm = jac_mot(mot_vec, args_new,d);
  Js = jac_str(str_vec, args_new, d);

  Jcalib_f = jac_calib_f(calibv, args_new, d);

  J = [Jcalib_f, Jm, Js];

endfunction