%proj_demo_bundle.m
%Comprehensive bundle adjustment
%
%2 examples of projective bundle adjustment
%example 1: motion only
%example 2: motion and structure
%each example has specific error and jacobian functions.
%optimisation is done in the optimise_fun function
%optimise_fun is very similar to fmin:
% the initial solution is stored in a vector, and the final
% (optimal) solution is returned in a vector with same length
% and same ordering of the variables. (The reason for making my 
% own fmin is to be able to use different strategies for the 
% dumping (lambda*eye(..)) matrix in the levenberg-marquardt algo).


clear
more off

base_path  = '../../../'

path(path, [base_path 'bundle']);
path(path, [base_path 'bundle/jac']);
path(path, [base_path 'bundle/err']);
path(path, [base_path 'bundle/solve']);
path(path, [base_path 'bundle/update']);
path(path, [base_path 'util']);
path(path, [base_path 'util/viewers']);
path(path, [base_path 'tracker']);


n=20; %number of  points
m=10; %number of cameras

max_iter = 5000;

%noise levels for our synthetic initial model:
sm = 0.01; %motion noise
ss = 0;    %structure
si = 0;    %image
sf = 0;    %focal length

%Generate some motion (actually circular around an object)

[mot, str, mot_n0, imgs, focals] = gen_mot10(m,n,sm,ss,si,sf);

%args1 contains data for the bundle adjustment that will not
%be passed through the parameters vector.

args1 = struct();
args1.m = m; %number of cameras
args1.n = n; %number of points (hm, actually contained in str)
args1.imgs = imgs; %image points, first row is the index
%args1.mot_n0 = mot_n0; %no motion as argument, (it's already in init sol.) 
args1.str = str; %the structure, needed in example 1 only
%args1.focals = focals; %we don't use focal lengthes in projective bundle

%Reshaping the parameters into a vector:

proj_mot_vec = [];
for i = 1:m,
    K = [focals(i) 0 0; 0 focals(i) 0; 0 0 1];
    K*mot_to_proj_mat(mot_n0{i});    
    ans'; proj_mot_vec = [proj_mot_vec;ans(:)]; 
    %NB: camera params are stacked rowwise in param vector
end


%%%%% Example 1
%Motion only

[proj_mot_vec_opt_1, err1, l1, C_vals1]=optimise_fun2(
                'err_proj_mot', ...      %error function
                'jac_proj_mot', ...      %corresponding jacobian
                [], ...                  % solving function e.g. if Jacobian is given as J'J
                [], ...                  %possibility for a specific update function
                args1, ...               %arguments
                proj_mot_vec, ...              %initial solution
                1000, 1e-1, 1000*eps);     %max iter, init lambd, tol

%Transforming the optimal solution vector C_opt1 back to 
%projection matrices:

proj_mot_opt1 = cell(m,1);
nb_mot_params = 12; %12 parameters in a projective projection matrix

for i = 1:m,
  proj_mot_opt1{i} = reshape(
       proj_mot_vec_opt_1((i-1)*nb_mot_params+1:i*nb_mot_params),
       4,3)';
end

%%%%%%% Example 2
%motion and structure
                
[proj_mot_str_vec_opt_2, err2, l2, C_vals2]=optimise_fun2(
                'err_proj_mot_str', 
                'jac_proj_mot_str',[], [], args1,
                [proj_mot_vec;str_to_vec(str)], 
                1000, 1e-1, 1000*eps);

%Extracting camera matrices and structure from the 
%optimal parameters vector (i.e. proj_mot_str_vec_opt_2)

proj_mot_vec_opt2 = proj_mot_str_vec_opt_2(1:nb_mot_params*m);
proj_str_vec_opt2 = proj_mot_str_vec_opt_2(nb_mot_params*m+1:end);

proj_mot_opt2 = cell(m,1);
nb_mot_params = 12; %12 parameters in a projective projection matrix

for i = 1:m,
  proj_mot_opt2{i} = reshape(
       proj_mot_vec_opt2((i-1)*nb_mot_params+1:i*nb_mot_params),
       4,3)';
end

proj_str_opt2 = vec_to_str(proj_str_vec_opt2);

%Do the reprojected points lie close to original ones?:
pflat(proj_mot_opt2{4}*proj_str_opt2)
imgs{4} %nb: point 1 is not visible in imagge 1
