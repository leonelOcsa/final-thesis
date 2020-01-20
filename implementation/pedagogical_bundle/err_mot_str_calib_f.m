%% Copyright (C) 2001-2009 Nicolas Guilbert
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

%% err = err_mot_str_calib_f(cal_mot_str_vec, args)
%% return the reprojection error, variable motion and focal length

function err = err_mot_str_calib_f(cal_mot_str_vec, args)


  m = args.m;
  n = args.n;
  imgs = args.imgs;
  
  nb_rot_params = args.parameterisation{1};
  nb_total_params = args.parameterisation{2};

  %assuming variable focal length only:
  %(todo: other intern params, given through args)
  
  mark1 = m; %marks end of intrinsic params
  mark2 = m+nb_total_params*m; %marks end of all cam params

  cal_vec = cal_mot_str_vec(1:mark1);
  mot_vec = cal_mot_str_vec(mark1+1:mark2);
  str_vec = cal_mot_str_vec(mark2+1:end);

  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;
  str = vec_to_str(str_vec);

  err = [];

  for i=1:m,
   
    K = [cal_vec(i) 0 0; 0 cal_vec(i) 0; 0 0 1];

    pt_indices = imgs{i}(1,:);

    imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];

  endfor
endfunction
