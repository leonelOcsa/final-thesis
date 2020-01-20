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

%% J = calc_sub_jacobian_proj(P, str)
%%
%% return the Jacobian submatrix corresponding to camera P and structure points P

function J = calc_sub_jacobian_proj(P, str)

  J = [];

  for i = 1:size(str,2),

    X = str(:,i);
    P3X = (P(3,:)*X);
    J = [J ;
         -[X', zeros(1,4), -X'*(P(1,:)*X)/P3X]/P3X
         -[zeros(1,4), X', -X'*(P(2,:)*X)/P3X]/P3X ];
  endfor
  
endfunction
