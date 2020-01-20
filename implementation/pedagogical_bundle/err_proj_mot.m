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


%% err = err_proj_mot(proj_mot_vec, args)
%% return the reprojection error, variable motion, projective

function err = err_proj_mot(proj_mot_vec, args)
  
  m = args{1};
  n = args{2};
  imgs = args{3};
  str = args{5};
  focals = args{6};

  nb_mot_params = 12;

  mot = cell(m,1);

  for i = 1:m,
    mot{i} = reshape(proj_mot_vec((i-1)*nb_mot_params+1:i*nb_mot_params), 4, 3)';
  end

  err=[];
  
  for i=1:m,

    pt_indices = imgs{i}(1,:);

%    K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];
%keyboard
    imgs{i}(2:4,:)-pflat(mot{i}*str(:, pt_indices)); ans(1:2,:);
    
    err = [err; ans(:)];
    
  end    
