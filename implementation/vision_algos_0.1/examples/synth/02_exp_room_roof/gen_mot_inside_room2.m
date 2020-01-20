function [mot, str, mot_n0, imgs, intr] = gen_mot_inside_room2(m,n,sm,ss,si,sf)

%function [mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf)
%generate motion circular
%m number of cameras, n number of points, s noise
  n = round(n/6);

  f = 100;
  m2 = m + 4;
  radius = 6;
  mot =cell(1,m2);
  imgs =cell(1,m2);

  thickness = .3

  wall1 = diag([3*radius, 3*radius, thickness])*rand(3,n); 
  wall1 = wall1 + radius*diag([-1.5 -1.5 -1.5])*ones(3,n);
  wall2 = diag([3*radius, 3*radius, thickness])*rand(3,n); 
  wall2 = wall2 + radius*diag([-1.5 -1.5 +1.5])*ones(3,n);
  wall3 = diag([thickness, 3*radius, 3*radius])*rand(3,n); 
  wall3 = wall3 + radius*diag([-1.5 -1.5 -1.5])*ones(3,n);
  wall4 = diag([thickness, 3*radius, 3*radius])*rand(3,n); 
  wall4 = wall4 + radius*diag([+1.5 -1.5 -1.5])*ones(3,n);

  wall5 = diag([3*radius, thickness, 3*radius])*rand(3,n); 
  wall5 = wall5 + radius*diag([-1.5 +1  -1.5])*ones(3,n);
  wall6 = diag([3*radius, thickness, 3*radius])*rand(3,n); 
  wall6 = wall6 + radius*diag([-1.5 -1  -1.5])*ones(3,n);




str = [wall1, wall2, wall3, wall4, wall5, wall6]; str = [str; ones(1, size(str,2))];

  mot_n0= mot;
  for i=1:m2,


    K= [f, 0 0; 0 f 0; 0 0 1];

  if i<=m, 
    T = [radius*cos(i/m*2*pi) 0 radius*sin(i/m*2*pi)]'+rand(3,1)*radius/10;

%    R = [cross([0 1 0],-T'/norm(T));0 1 0 ;-T'/norm(T)]; %for testing that the quaternion is right

    theta = i/m*2*pi+pi/2;
    d = [-.1 1 .2]';%+[1 0 1]*1e-1*radius*rand(3,1); d = d/norm(d);%to avoid degenerate cases for affine cams
  else
    if i == m+1,
      T = [7 5 7]';
      theta = pi;
      d = -[-1 -1 1]'; 
    elseif i == m+2,
      T = [7 5 -7]';
      theta = 4*pi/2;
      d = [1 1 1]'; 
    elseif i ==m +3
      T = [5 -5 -5]';
      theta = pi/4;
      d = [1 1 1]'; 
    elseif i ==m +4
      T = [7 -5 7]';
      theta = pi;
      d = [-1 1 1]'; 
     end
  end
  
    mot{i}= {angle_axis_to_exp_map(theta,d), T};

    cam = K*mot_to_proj_mat(mot{i});
    x_tmp = cam*str;

    pt_indices1 =  find(x_tmp(3,:)>0);
    x_tmp = pflat(x_tmp);
    pt_indices2 =  intersect(find(abs(x_tmp(1,:))<f*sin(pi/4)),...
                             find(abs(x_tmp(2,:))<f*sin(pi/4)));

    pt_indices = intersect(pt_indices1, pt_indices2);

    imgs{i} = [pt_indices; x_tmp(:, pt_indices)];

%    mot_n0{i} = mot{i};
%    mot_n0{i}{1} = mot{i}{1};
%    mot_n0{i}{2} = mot{i}{2} + sm*randn(3,1);
  end

%setting last camera (m) "equal" to first one
tmpimg = imgs{m2};
tmpmot = mot{m2};
imgs{m2} = imgs{m};
mot{m2} = mot{m};
imgs{m} = tmpimg;
mot{m} = tmpmot;

%str(1:3,:) = str(1:3,:) + ss*randn(3,n);

intr = zeros(m,5); intr(:,1)=f;


