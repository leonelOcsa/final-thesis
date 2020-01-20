function imgs = del_track_from_seq(imgs, idx)

%function imgs = del_track_from_seq(imgs, idx)
%
%deletes the image point with index idx from all the images
%in imgs

for i = 1:length(imgs),
  imgs{i} = imgs{i}(:, find(imgs{i}(1,:)~=idx));
end

