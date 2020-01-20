function imagesc_with_features(img, img_points, zoom)

if nargin <3, 
  zoom = 1;
end

n = size(img_points,2);

feat_col = max(img(:))*1.5;

for i = 1:n,
  r = round(img_points(3,i));
  c = round(img_points(2,i));
  img(r,c) = feat_col;
end

imagesc(img,zoom)

