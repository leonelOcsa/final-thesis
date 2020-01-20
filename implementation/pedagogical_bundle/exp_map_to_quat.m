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

%% q = exp_map_to_quat(v)
%% return quaternion representation of a rotation represented by the exponential map

function q = exp_map_to_quat(v)

v  = [v(1) v(2) v(3)]';
if v == [0 0 0]', q = [0 0 0 0]';, 
else
  nv = norm(v);
  q = [v/nv*sin(nv/2); cos((nv)/2)];
end
