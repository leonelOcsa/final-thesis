function imagesc_with_points(I,pts, intensity, zoom)


for i = 1:size(pts,1)
  I(pts(i,1)  ,pts(i,2))=intensity;
  I(pts(i,1)+1,pts(i,2))=intensity;  
  I(pts(i,1)-1,pts(i,2))=intensity;
  I(pts(i,1)  ,pts(i,2)+1)=intensity;  
  I(pts(i,1)  ,pts(i,2)-1)=intensity;  
end

imagesc(I,zoom);
