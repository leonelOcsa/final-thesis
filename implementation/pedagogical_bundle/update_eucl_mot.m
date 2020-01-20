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

%% newX = update_eucl_calib_mot_str(in_list)
%% update function for a updating motion parameters
%% in the Levenberg-Marquardt minimizer

function newX = update_eucl_mot(in_list)

X_opt = in_list{1};
d = in_list{2};
args = in_list{3};

newX = X_opt;

m = args.m;
n = args.n;

nb_total_params = args.parameterisation{2};
nb_rot_params = args.parameterisation{1};

for i = 1:m,
	rng_rot = (i-1)*nb_total_params+1:(i-1)*nb_total_params+nb_rot_params;
	if nb_rot_params ==3,
		oldR = expm(skew_mat(X_opt(rng_rot)));
		newR = expm(skew_mat(-d(rng_rot)))*oldR; real(logm(newR));
		newX(rng_rot)=[ans(3,2), ans(1,3), ans(2,1)]';
	elseif nb_rot_params==4, 
		newX(rng_rot) = X_opt(rng_rot)-d(rng_rot);%quaternion rep.
	end

	rng_trans = (i-1)*nb_total_params+nb_rot_params+1:i*nb_total_params;
	newX(rng_trans)= X_opt(rng_trans)-d(rng_trans);
end



	


