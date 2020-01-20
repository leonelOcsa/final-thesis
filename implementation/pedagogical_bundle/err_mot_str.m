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

%% err = err_mot_str(mot_str_vec, args)
%% return the reprojection error, variable motion and structure

function err = err_mot_str(mot_str_vec, args)

  nb_total_params = args.parameterisation{2};
  nb_rot_params = args.parameterisation{1};

  m = args.m;
  n = args.n;
  imgs = args.imgs;

  focals = args.focals;	
  mot_vec = mot_str_vec(1:nb_total_params*m);
  str_vec = mot_str_vec(nb_total_params*m+1:length(mot_str_vec));


  mot = vec_to_mot_tuples(mot_vec, args.parameterisation) ;

  str = vec_to_str(str_vec);

  err=[];
  
  for i=1:m,

   pt_indices = imgs{i}(1,:);

   K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];

   imgs{i}(2:4,:)-pflat(K*mot_to_proj_mat(mot{i})*str(:,pt_indices)); ans(1:2,:);
    err = [err; ans(:)];
  endfor
endfunction
