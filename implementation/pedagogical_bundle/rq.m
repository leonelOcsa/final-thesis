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

%% [r,q]=rq(a)
%% RQ [r,q]=rq(a) factorises a such a=rq where r upper tri. and q unit matrix
%% If a is not square, then q is equal q=[q1 q2] where q1 is unit matrix

function [r,q]=rq(a)

[m,n]=size(a);
e=eye(m);
p=e(:,[m:-1:1]);
[q0,r0]=qr(p*a(:,1:m)'*p);

r=p*r0'*p;
q=p*q0'*p;

fix=diag(sign(diag(r)));
r=r*fix;
q=fix*q;

if n>m
  q=[q, inv(r)*a(:,m+1:n)];
end
