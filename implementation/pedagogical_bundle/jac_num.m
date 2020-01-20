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

%% J = jac_num(f, x0, args,d) 
%% return J the numerically evaluated Jacobian df/dx0

function J = jac_num(f, x0, args,d) 

%function J = jac_num(f, x0, args,d) 
%J = df/dx at x0
  
    J = [];
    f0 = feval(f,x0,args);
    
    for i = 1:length(x0)
      
      delta = zeros(size(x0));
      delta(i) = d;
      
      J = [J, (feval(f,x0+delta,args) - f0 )/d];
    end
    
    
