function [mot, str, mot_n0, imgs, intr] = gen_mot_box(m,n,sm,ss,si,sf)

%function [mot, str, mot_n0, imgs, focals] = gen_mot10(m,n,sm,ss,si)
%function [mot, mot_n0, imgs] = gen_mot1(m,n,s)
%generate motion circular
%m number of cameras, n number of points, s noise

  f = 1000;
  radius = 10;
  mot =cell(1,m);
  imgs =cell(1,m);
  str = [5*rand(3,n); ones(1,n)];


  mot_n0= mot;
  for i=1:m,

    K= [f, 0 0; 0 f 0; 0 0 1];

    T = [radius*cos(i/m*2*pi) 0 radius*sin(i/m*2*pi)]';

%    R = [cross([0 1 0],-T'/norm(T));0 1 0 ;-T'/norm(T)]; %for testing that the quaternion is right

    theta =i/m*2*pi+pi/2;
    mot{i}= {angle_axis_to_exp_map(theta,[0 1 0]'), T};
    pflat(K*mot_to_proj_mat(mot{i})*str);
    imgs{i} = [1:n;ans+si*randn(size(ans))];

    mot_n0{i} = mot{i};
    mot_n0{i}{1} = mot{i}{1};
    mot_n0{i}{2} = mot{i}{2} + sm*randn(3,1);
  end

str(1:3,:) = str(1:3,:) + ss*randn(3,n);

focals = f*ones(1,m)+sf*randn(1,m);

intr = zeros(m,5);
intr(:,1)=f;
intr(:,2)=1;

