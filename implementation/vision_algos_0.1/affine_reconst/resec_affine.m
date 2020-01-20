function mot = resec_affine(X,img);


nb_points = size(img,2);
S = zeros(2*nb_points,8);

pt_indices = img(1,:);

%keyboard
  for i = 1:nb_points,
    S((i-1)*2+1:(i-1)*2+2,:)=kron(X(:,i)',eye(2));
  end

img(2:3,:);

%keyboard
mot = [reshape(S\ans(:),2,4); 0 0 0 1];

