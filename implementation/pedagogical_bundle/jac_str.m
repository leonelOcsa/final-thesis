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

%% J = jac_str(str_vec, args, dummy)
%% return J i.e. df/dstr where f is the reprojection function,
%% and str the structure parameters, euclidian parameterisation

function J = jac_str(str_vec, args, dummy)

  m = args.m;
  n = args.m;
  imgs = args.imgs;
  mot = args.mot;
  str = vec_to_str(str_vec);
  nb_str_params = 3;


  nb_img_points = 0;
  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  endfor

  J=zeros(nb_img_points*2,n*nb_str_params);

  cur_J_row = 1;  
  
  for i=1:m,

    pt_indices = imgs{i}(1,:);

    cur_P = mot_to_proj_mat(mot{i});
    reproj = cur_P*str(:, pt_indices);

    for j = 1:length(pt_indices),

      cur_idx = pt_indices(j);
      J( cur_J_row:cur_J_row+1,...
         (cur_idx-1)*nb_str_params+1:(cur_idx)*nb_str_params) =...
                  -(cur_P(1:2,1:nb_str_params)*reproj(3,j) - ...
                   reproj(1:2,j)*cur_P(3,1:nb_str_params))/reproj(3,j)^2;

     cur_J_row = cur_J_row+2;
    endfor
  endfor

endfunction