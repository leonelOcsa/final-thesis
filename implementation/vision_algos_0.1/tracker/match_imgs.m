function idx2 = match_imgs(img1_name, img2_name, img1, img2, H)

%function idx2 = match_imgs(img1_name, img2_name, img1, img2, H)
%img1_name : path to image 1
%img1: coordinates of image points (4xn)
%H: assumed transformation between the images
%idx2: img1(i) <-> img2(idx2(i))

%extract relevant patches from the image
%calculate correlation scores C
%calculate proximity scores P given H
%run lap on C.*P, possibly eliminate clear loosers to reduce problem

if ~isempty(img1) && ~isempty(img2),

data1 = imread(img1_name);
data2 = imread(img2_name);

nb_pts1 = size(img1,2); nb_pts2 = size(img2,2);

patches1 = cell(nb_pts1,1); patches2 = cell(nb_pts2, 1);

phs = 5; %patch half size

for i = 1:nb_pts1,%nb: swapping x/y -> row/col
  patches1{i} = data1((-phs:phs)+img1(3,i), (-phs:phs)+img1(2,i));
end

for i = 1:nb_pts2,%nb: swapping x/y -> row/col
  patches2{i} = data2((-phs:phs)+img2(3,i), (-phs:phs)+img2(2,i));
end

img1_H = H*img1(2:4,:);

X1 = img1_H(1,:)'*ones(1,nb_pts2);
X2 = ones(nb_pts1,1)*img2(2,:);
Y1 = img1_H(2,:)'*ones(1,nb_pts2);
Y2 = ones(nb_pts1,1)*img2(3,:);
%keyboard

P = (X1-X2).^2 + (Y1-Y2).^2;
std_dev = 20;
P = exp(-P/std_dev^2);P = P/max(P(:));


C = calc_corr_prox_mat(patches1, patches2, P>.1)+1;
%P.*C; M1 = ans.*(ans>.3)-1;
P.*C; M1 = ans-1;

M2 = lap(M1);
idx2 = M2*(1:nb_pts2)';

else 
  idx2 = [];
end
