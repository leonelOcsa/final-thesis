function new_imgs = merge_tracks(imgs, track_ids)

%function new_imgs = merge_tracks(imgs, track_identities)

%we want smallest elem in first column
for i = 1:size(track_ids,1)
  if track_ids(i,1) > track_ids(i,2),
    tmp = track_ids(i,1); track_ids(i,1)=track_ids(i,2); track_ids(i,2)=tmp;
  end
end

[slask, idx] = sort(track_ids(:,1));

track_ids = track_ids(idx, :);

for cur_repl_idx = 1:track_ids(end,1),
  cur_repl_idx
  tg_idx = track_ids(find(track_ids(:,1)==cur_repl_idx),:);
  tg_idx = unique(tg_idx);
  for j=2:length(tg_idx), %for every idx to be replaced
    for k=1:length(imgs) %for every img sequence
      for l=1:length(imgs{k}) %for every image
	if(length(find(imgs{k}{l}(1,:)== cur_repl_idx))==0) 
          imgs{k}{l}(1,find(imgs{k}{l}(1,:)==tg_idx(j))) = cur_repl_idx;
	  %disp('dup problem\n'), 
	end;
      end
    end
  end
end

for i = 1:length(imgs), imgs{i} = reorder_img_indices(imgs{i}); end;
