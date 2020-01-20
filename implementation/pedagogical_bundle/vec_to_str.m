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

%% str  = vec_to_str(strv)
%% return the homogenous structure coordinates from their vectorised form strv

function str  = vec_to_str(strv)

  nb_str_params = 3;
  n = length(strv)/nb_str_params;
  str = reshape(strv,nb_str_params,n);
  str = [str; ones(1, size(str,2))];
