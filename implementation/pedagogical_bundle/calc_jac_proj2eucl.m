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

%% function J = calc_jac_proj2eucl (mot_tuple, focal_length)
%%
%% return the Jacobian J J_p 

function J = calc_jac_proj2eucl(mot_tuple, focal_length)

  B1 = skew_mat([1 0 0]); 
  B2 = skew_mat([0 1 0]); 
  B3 = skew_mat([0 0 1]); 
  T = mot_tuple{2};
  R = expm(skew_mat(mot_tuple{1}));
  dR1 = B1*R;
  dR2 = B2*R;
  dR3 = B3*R;
  
  
  J =[dR1(:), dR2(:), dR3(:) ,zeros(9,3);[-dR1*T, -dR2*T, -dR3*T, ], -R];
  
  
  J = J([1 4 7 10 2 5 8 11 3 6 9 12], :);

endfunction