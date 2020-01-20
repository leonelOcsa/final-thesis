function M = gen_track_mat(imgs);

tracks   = [];
for i = 1:length(imgs),
  tmp = imgs{i}(1,:)';
  tracks = [tracks;i*ones(size(imgs{i},2),1),tmp];
end
M = zeros(max(tracks(:,1)), max(tracks(:,2)));
for i = 1:size(tracks,1),
  M(tracks(i,1), tracks(i,2)) = 1;
end
