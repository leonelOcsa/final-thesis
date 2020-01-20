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

%% motveucl = mot_to_vec_eucl(mot)
%% return motveucl, a vectorised form of the motion tuples in mot

function motveucl = mot_to_vec_eucl(mot)

  motveucl = [];
  for i = 1:length(mot)
    motveucl =  [motveucl; mot{i}{1}; mot{i}{2}];
  end

endfunction
