function imseq =read_image_data_from_file(fname)

tmp = read_raw_tracks(fname);

m = length(unique(tmp(:,2)));
n = length(unique(tmp(:,1)));
imseq = cell(1,m);

idx_lut = unique(tmp(:,1));

for k = 1:m,
    p = find(tmp(:,2)==k-1)';
    imagedata = tmp(p,[1 3 4])';
    for i = 1:size(imagedata,2),
      imagedata(1,i) = find(idx_lut==imagedata(1,i));
        %pts(:,find(idx_lut==tmp(p,1))) = tmp(p,[3 4])';
    end
    imseq{k} = imagedata;

end
