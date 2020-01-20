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

%% P = mot_to_proj_mat(mot_tuple)
%% return P the projection matrix

function P = mot_to_proj_mat(mot_tuple)

if length(mot_tuple{1})==4,
  P = quaternion_to_rmat(mot_tuple{1})*[eye(3), -mot_tuple{2}];
elseif length(mot_tuple{1})==3
  P = expm(skew_mat(mot_tuple{1}))*[eye(3), -mot_tuple{2}];
end
