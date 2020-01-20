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

%% [mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf)
%% return a sample motion mot, structure str, motion with noise mot_n0,
%% reprojections (image points) imgs and focal lengths focals
%% m: number of cameras
%% n: number of structure points
%% sm, ss, si, sf: noise on motion, structure, image points and focals

function [mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf)

  f = 1;
  radius = 6;
  mot =cell(1,m);
  imgs =cell(1,m);
  str = [rand(3,n); ones(1,n)];


  mot_n0= mot;
  for i=1:m,

    K= [f, 0 0; 0 f 0; 0 0 1];

    T = [radius*cos(i/m*2*pi) 0 radius*sin(i/m*2*pi)]'+rand(3,1)*radius/10;;

  %    R = [cross([0 1 0],-T'/norm(T));0 1 0 ;-T'/norm(T)]; %for testing that the quaternion is right

    theta =i/m*2*pi+pi/2;
    d = [-.1 1 .2]';%to avoid degenerate cases for affine cams
    mot{i}= {angle_axis_to_exp_map(theta,d), T};

    %affine cameras:
    K*mot_to_proj_mat(mot{i}); ans/ans(end,end); 


    pflat(ans*str);
    ans(1:2,:) = ans(1:2,:) + si*randn(2, size(ans,2));
    imgs{i} = [1:n;ans];

    mot_n0{i} = mot{i};
    mot_n0{i}{1} = mot{i}{1};
    mot_n0{i}{2} = mot{i}{2} + sm*randn(3,1);
  end

str(1:3,:) = str(1:3,:) + ss*randn(3,n);

focals = f*ones(1,m)+sf*randn(1,m);
endfunction