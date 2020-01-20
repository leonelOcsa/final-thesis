function [mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf)

%function [mot, str, mot_n0, imgs, focals] = gen_mot11(m,n,sm,ss,si,sf)
%generate motion circular
%m number of cameras, n number of points, s noise

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
    d = [-.1 1 .2]';%+[1 0 1]*1e-1*radius*rand(3,1); d = d/norm(d);%to avoid degenerate cases for affine cams
    mot{i}= {angle_axis_to_exp_map(theta,d), T};

    %affine cameras:
    K*mot_to_proj_mat(mot{i}); ans/ans(end,end); %ans(3,1:3) = 0;
%keyboard

    pflat(ans*str);
    ans(1:2,:) = ans(1:2,:) + si*randn(2, size(ans,2));
    imgs{i} = [1:n;ans];

    mot_n0{i} = mot{i};
    mot_n0{i}{1} = mot{i}{1};
    mot_n0{i}{2} = mot{i}{2} + sm*randn(3,1);
  end

str(1:3,:) = str(1:3,:) + ss*randn(3,n);

focals = f*ones(1,m)+sf*randn(1,m);
%keyboard
%imgs{1} = imgs{1}(:,2:n);
%imgs{2} = imgs{2}(:,2:n);
%imgs{m} = imgs{m}(:,1:n-3);
