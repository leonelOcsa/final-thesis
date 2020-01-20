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

%% R = quaternion_to_rmat(q)
%% return the rotation matrix R defined by the quaternion q

function R = quaternion_to_rmat(q)


if ~q, R = eye(3); 
else

  q = q/norm(q);

  R = [ q(1)*q(1) - q(2)*q(2) - q(3)*q(3) + q(4)*q(4),  -2*(q(3)*q(4) - q(1)*q(2)), 2*(q(2)*q(4) + q(1)*q(3));
  2*(q(4)*q(3) + q(1)*q(2)), -q(1)*q(1) + q(2)*q(2) - q(3)*q(3) + q(4)*q(4),2*(q(2)*q(3) - q(1)*q(4));
  -2*(q(4)*q(2) - q(1)*q(3)), 2*(q(3)*q(2) + q(1)*q(4)),q(1)*q(1) + q(2)*q(2) - q(3)*q(3) - q(4)*q(4)];

end


