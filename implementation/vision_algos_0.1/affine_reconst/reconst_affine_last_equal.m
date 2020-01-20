function [mot, new_imgs] = reconst_affine_last_equal(imgs,pair_mat, r_f)

%function mot = 
%reconst_affine(imgs,pair_mat, ransac_features)
%pair_mat is an upper triangular matrix specifying whether
%the fund_mat between two views should be used for computations.
%the diagonal is zero

m = length(imgs);

%ensure that pair_mat has right format:
pair_mat = pair_mat.*upper_triang_ones(size(pair_mat,1));

tic
max_credib = 0;
StS = zeros(m*2);
StSe = zeros(m*2,4);

if r_f==0,
  new_imgs = imgs;
else
  new_imgs = cell(m,1);
end

for j = 2:m, %view 2
  for i =1:j-1, %view 1
    if pair_mat(i,j)==1,
    
      n1 = i;
      n2 = j;
      x1_orig = imgs{n1};
      x2_orig = imgs{n2};
    
      [x1,x2]= select_common_features(x1_orig, x2_orig);
    
    
      if r_f,
        [F,credibility, inlier_idx] = fund_mat_affine_ransac2(x1(2:end,:), x2(2:end,:));
        
        new_imgs{i} = merge_image_point_groups(new_imgs{i}, x1(:, inlier_idx));
        new_imgs{j} = merge_image_point_groups(new_imgs{j}, x2(:, inlier_idx));
        [i,j, size(new_imgs{i},2) size(new_imgs{j},2) size(imgs{i},2) size(imgs{j},2)]
      else
        [F,credibility] = fund_mat_affine(x1(2:end,:), x2(2:end,:));
      end
    
      if credibility>max_credib,
        winning_pair = [i,j];
        max_credib = credibility;
      end
      
      [a,b,c] = svd(F);
      F = F/norm(F); 
    
      if isempty(x1),
      disp('error, no common features in views');
      end
    
      block1 = [F(1,3) F(2,3)];
      block2 = [F(3,1) F(3,2)];
      StS(2*(j-1)+1:2*j,2*(j-1)+1:2*j) = StS(2*(j-1)+1:2*j,2*(j-1)+1:2*j)+block2'*block2;
      StS(2*(i-1)+1:2*i,2*(i-1)+1:2*i) = StS(2*(i-1)+1:2*i,2*(i-1)+1:2*i)+block1'*block1;
      StS(2*(i-1)+1:2*i,2*(j-1)+1:2*j) = StS(2*(i-1)+1:2*i,2*(j-1)+1:2*j)+block1'*block2;
      StS(2*(j-1)+1:2*j,2*(i-1)+1:2*i) = StS(2*(j-1)+1:2*j,2*(i-1)+1:2*i)+block2'*block1;
      StSe([2*(i-1)+1:2*i 2*(j-1)+1:2*j],4) = StSe([2*(i-1)+1:2*i 2*(j-1)+1:2*j],4) - F(3,3)*[block1';block2'];
    end
  end
end

fixed_gauge_cams = winning_pair;

fgc1  = fixed_gauge_cams(1);
fgc2  = fixed_gauge_cams(2);

fgc1 = 1;
fgc2 = 7;

%move values from S to Se for camera 1:
StSe = StSe - StS(:,2*(fgc1-1)+1:2*fgc1)*[1 0 0 0; 0 1 0 0];
%StSe = StSe - StS(:,2*fgc2)*[0 1 .1 0];
StSe = StSe - StS(:,2*fgc2-1)*[1 0 1 0];
StSe = StSe - StS(:,2*(m-1)+1:2*m)*[1 0 0 0; 0 1 0 0];

%StS = StS([1:2*(fgc1-1), 2*fgc1+1:2*fgc2-1, 2*fgc2+1:end-2],[1:2*(fgc1-1), 2*fgc1+1:2*fgc2-1 2*fgc2+1:end-2]);

%rng = [1:2*(fgc1-1), 2*fgc1+1:2*fgc2-1, 2*fgc2+1:size(StS,1)-2];
rng = [1:2*(fgc1-1), 2*fgc1+1:2*(fgc2-1), 2*fgc2:size(StS,1)-2];
StS = StS(rng, rng);
StSe = StSe(rng,:);

cond(StS)
StS = sparse(StS);
S_sol = (StS)\(StSe);
S_sol = S_sol;

mot = cell(m,1);

cur_pos = 1;
for i = 1:m,

  if i == fgc1%fixed_gauge_cams(1),
    mot{i} = [1, 0, 0, 0; 0, 1, 0, 0; 0 0 0 1];
  elseif i == fgc2,
%    mot{i} = [S_sol(cur_pos,:); 0 1 0; 0 0 0 1];
    mot{i} = [1 0 1 0; S_sol(cur_pos,:); 0 0 0 1];
    cur_pos = cur_pos + 1;
  elseif i == m,
     mot{i} = mot{1};

  else
    mot{i} = [S_sol(cur_pos:cur_pos+1,:);0 0 0 1];
    cur_pos = cur_pos + 2;
  end

end
