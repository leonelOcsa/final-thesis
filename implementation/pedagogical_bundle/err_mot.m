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

%% err = err_mot(mot_vec, args)
%% return the reprojection error, variable motion in mot_vec

function err = err_mot(mot_vec, args)

  
  m = args.m;
  n = args.n;
  imgs = args.imgs;
  str = args.str;
  focals = args.focals;

  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;
  
  err=[];
  
  for i=1:m,

    pt_indices = imgs{i}(1,:);

    K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];
    imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:, pt_indices)); ans(1:2,:);
    err = [err; ans(:)];

  endfor
endfunction
