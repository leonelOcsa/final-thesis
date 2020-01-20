
%sample script for euclidian bundle adjustment
more off
clear
n=10;
m=3;

max_iter = 5000;

%noise levels:
sm = 0;
ss = 0;
si = 0.01;
sf = 0;

[mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf);

motveucl = mot_to_vec_eucl(mot_n0);
strvec = str_to_vec(str);
motstrvec = [motveucl; strvec];
calibv=focals';

args1.m = m; 
args1.n = n;
args1.imgs = imgs;
args1.mot = mot_n0;
args1.str = str;
args1.focals = focals; %intrinsic parameters
args1.parameterisation = {3,6}; %parameterisation, {nb_rot_params, nb_total_params}


%optimizing over motion (extrinsic) parameters
[C_opt1a, err1, l1,C_vals1]=optimise_fun('err_mot', 'jac_mot','update_eucl_mot',args1, motveucl, 20, 1e-5, 1000*eps);

%3D structure parameters
[C_opt2, err2, l2, C_vals2]=optimise_fun('err_str', 'jac_str', [],args1, strvec, 6, .0001, 100*eps);

%motion and structure params
[C_opt3, err3, l3,C_vals3]=optimise_fun('err_mot_str', 'jac_mot_str','update_eucl_mot_str', args1, motstrvec, 2000, 1e-5, 1000*eps);

%focal length
[C_opt4, err4, l4, C_vals4]=optimise_fun('err_calib_f', 'jac_calib_f',[],args1, calibv, 20, 100, 100*eps);

%focal length, motion and struct params
calibmotstrvec = [calibv; motstrvec]
[C_opt5, err5, l5, C_vals5_num]=optimise_fun('err_mot_str_calib_f', 'jac_mot_str_calib_f', 'update_eucl_calib_mot_str', args1, calibmotstrvec , 2000, 1e-1, 100*eps);

