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

%% J = jac_proj_mot_str(proj_mot_str_vec, args, dummy)
%% return J [df/dmot, df/dstr] where f is the reprojection function,
%% mot are the motion parameters and str the structure parameters

function J = jac_proj_mot_str(proj_mot_str_vec, args, dummy)

nb_total_params = 12;

m = args{1}; n = args{2};

mot_vec = proj_mot_str_vec(1:nb_total_params*m);
str_vec = proj_mot_str_vec(nb_total_params*m+1:end);

proj_args = cell(6,1);
proj_args{1} = args{1}; %m
proj_args{2} = args{2}; %n
proj_args{3} = args{3}; %imgs

proj_args{4} = mot_vec;
proj_args{5} = vec_to_str(str_vec);
proj_args{6} = args{6}; %focals

J = [jac_proj_mot(mot_vec, proj_args, dummy),...
jac_proj_str(str_vec, proj_args, dummy)];

endfunction