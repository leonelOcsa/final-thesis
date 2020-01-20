function imgs  = casino_data_to_imgs(name)

imgs_raw = read_raw_tracks(name);

m = imgs_raw(end,2);
n = imgs_raw(end,1);

imgs = cell(m,1);

for i = 1:m+1,
  row_idx = find(imgs_raw(:,2)==i-1);
  imgs{i} = imgs_raw(row_idx,[1 3 4])';
  imgs{i} = [imgs{i}; ones(1,size(imgs{i},2))];
end

%reorder img indices
img_idx_set = [];
for i = 1:length(imgs),
%  img_idx_set = create_set([img_idx_set,imgs{i}(1,:)]);

  img_idx_set = unique([img_idx_set,imgs{i}(1,:)]);
end

img_idx_set = sort(img_idx_set);

for i = 1:length(imgs),
  for j = 1:size(imgs{i},2),
    imgs{i}(1,j) = find(img_idx_set==imgs{i}(1,j));
  end
end
