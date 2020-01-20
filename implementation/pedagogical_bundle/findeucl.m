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

%% e = findeucl(data1,data2);
%% return the euclidean transformation e
%% mapping the 3D points in data1 onto data2, least squares fit

function e = findeucl(data1,data2);

  x = pflat(getpoints(data1));
  y = pflat(getpoints(data2));

  m = size(x,1)-1;
  x = x(1:m,:);
  y = y(1:m,:);

  n = size(x,2);
  X1= y; X2 = x;

  m1 = mean(X1');  
  m2 = mean(X2');  

  X1 = X1-m1'*ones(1,n); %determining centroid
  X2 = X2-m2'*ones(1,n);

  s1 = sum(sum(X1.^2).^.5); %determining scale
  s2 = sum(sum(X2.^2).^.5); 

  X1 = X1/s1;
  X2 = X2/s2;

  M = zeros(3); %determining rotation
  for i =1:n
    M = M+X1(:,i)*X2(:,i)';
  endfor

  [u,d,v] = svd(M);

  R = u*v'; 

  if det(R)<0, 
    eye(m); ans(m,m) = -1;
    R = u*ans*v'; 
  endif
    e = [s1/s2*R, -s1/s2*R*(m2')+m1'; zeros(1,m) 1];

endfunction