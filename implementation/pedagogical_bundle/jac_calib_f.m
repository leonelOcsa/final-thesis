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

%% J = jac_calib_f(calib_f_vec, args, dummy)
%% return dP/dcalib_f, i.e. the jacobian of the projective camera parameters
%% wrt. the focal length

function J = jac_calib_f(calib_f_vec, args, dummy)

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = args.mot;
  str = args.str;

nb_img_points =0;

  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  endfor

  J=zeros(nb_img_points*2,m);

  cur_J_row = 1;  

  for i = 1:m,

    K = [calib_f_vec(i) 0 0; 0 calib_f_vec(i) 0; 0 0 1];	

    pt_indices = imgs{i}(1,:);

    reproj = mot_to_proj_mat(mot{i})*str(:,pt_indices);

    reproj_xy_vec = reproj(1:2,:)(:);
    reproj_2z = kron(reproj(3,:)',[1 1]');

    J(cur_J_row:cur_J_row+2*length(pt_indices)-1,i) =...
    -reproj_xy_vec(:,1)./reproj_2z;

    cur_J_row =  cur_J_row + 2*length(pt_indices);


  endfor
endfunction