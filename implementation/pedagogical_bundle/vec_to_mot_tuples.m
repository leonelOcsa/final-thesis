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

%% tup = vec_to_mot_tuples(mot_vec,parameterisation)
%% return the motion tuples tup from their vectorised form mot_vec

function tup = vec_to_mot_tuples(mot_vec,parameterisation)

nb_rot_params = parameterisation{1};
nb_total_params = parameterisation{2};

n = length(mot_vec)/nb_total_params;
tup = cell(n,1);

cur_idx = 1;

for i = 1:n,
  tup{i} = {mot_vec(cur_idx:cur_idx+nb_rot_params-1),
	    mot_vec(cur_idx+nb_rot_params:cur_idx+nb_total_params-1)};
  cur_idx = cur_idx + nb_total_params;
end
