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

%% J = jac_proj_mot(mot_vec, args, dummy)
%% return J df/dmot where f is the reprojection function and mot are
%% the motion parameters

function J = jac_proj_mot(mot_vec, args, dummy)


  nb_mot_params =12;

  m = args{1};
  n = args{2};
  imgs = args{3};
  str = args{5};

  focals = args{6};

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = reshape(mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 4, 3)';
  endfor

  nb_img_points = 0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  endfor

  J=zeros(nb_img_points*2,m*nb_mot_params);

  cur_J_row = 1;

  for i=1:m,

    pt_indices = imgs{i}(1,:);
    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,
       (i-1)*nb_mot_params+1:i*nb_mot_params) =...
	calc_sub_jacobian_proj(mot{i},str(:,pt_indices));

    cur_J_row =  cur_J_row + 2*length(pt_indices);

  endfor
endfunction
