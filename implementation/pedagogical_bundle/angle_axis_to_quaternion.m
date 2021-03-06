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

%% v = angle_axis_to_quaternion (theta, a)
%%
%% return the quaternion representation of angle-axis representation of a rotation

function q = angle_axis_to_quaternion(theta, a)

a = a/norm(a);

sint = sin(theta/2);
q = [cos(theta/2); a*sint];

q = q/norm(q); %make sure norm(q)==1 (rounding errors).

endfunction