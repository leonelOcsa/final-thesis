function J = jac_focal(f_vec, args, dummy)

  m = args.m;
  n = args.n;
  imgs = args.imgs;
  mot = args.mot;
  str = args.str;
  intrinsics = args.intrinsics;
  nb_img_points =0;
  for i = 1:m,
    nb_img_points = nb_img_points+size(imgs{i},2);
  end
  J=zeros(nb_img_points*2,m);
  cur_J_row = 1;
  for i = 1:m,
    calib = intrinsics(i,:);
    K_prime = [1  calib(3) calib(4);
               0  calib(2) calib(5);
               0  0        1];

    pt_indices = imgs{i}(1,:);
    %err2 = (xm - pflat(PX))^2
    %derr2/df = -2 d(pflat(PX)).*err/df
    %         = -2 d(pflat(K*R*[I,t]*X)).*err/df
    %         = -2 d(K(1:2,:)*R*[I,-t]*X./K(3,:)*R*[I,-t])*X.*err/df
    %         = -2 d(K(1:2,:))/df * R*[I, -t]*X./K(3,:)*R[I,-t]*X./err

    reproj = K_prime*mot_to_proj_mat(mot{i})*str(:,pt_indices);
    reproj(1:2,:); reproj_xy_vec =ans(:);
    reproj_2z = kron(reproj(3,:)',[1 1]');

%%%%%%%alternative
%   f = calib(1);
%   K = [f f*calib(3) f*calib(4)
%        0 f*calib(2) f*calib(5)
%	0 0            1];

%   P = K * mot_to_proj_mat(mot{i});
%   proj_jac = calc_sub_jacobian_proj(P, str(:,pt_indices));
%   K_prime2 = [1 calib(3) calib(4)
%        0 calib(2) calib(5)
%	0 0            0];


%   K_prime2*mot_to_proj_mat(mot{i}); ans'
%   jp2e = ans(:);
%%%%end alternative

J(cur_J_row:cur_J_row+2*length(pt_indices)-1,i) =...
    -reproj_xy_vec(:,1)./reproj_2z;
%    proj_jac*jp2e; %alternative

%keyboard
cur_J_row =  cur_J_row + 2*length(pt_indices);
  end

