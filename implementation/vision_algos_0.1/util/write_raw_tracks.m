function write_raw_tracks(imseq, fname)

%function write_raw_tracks(imseq, fname)
%

fp = fopen(fname, 'w');
%if(fp)
  for k = 1:length(imseq)
    k
    pts = imseq{k};
    for l = 1:size(pts,2)
      tmp2 = [pts(2,l),pts(3,l)];
%      tmp2 = ones(2,1);
	if ~isnan(tmp2(1)),
          %tmp = ([0, 0, l-1, k-1, k-1, 0]);
          tmp = [pts(1,l)-1, k-1];
          fwrite(fp, tmp,'int');
          fwrite(fp, tmp2,'double');
        end
    end
  end
  fclose(fp);
%else
%  disp('hallo')
%  a = 1
%end

%if(fp)
%    imseq = [];
%    while(feof(fp) == 0)
%        tmp = fread(fp, 6, 'int');
%        tmp2 = fread(fp, 2, 'double');
%        
%        if(length(tmp) == 6 & length(tmp2) == 2)
%            imseq = [imseq; tmp([3 4])' tmp2'];  
%        end
%    end
%    fclose(fp);
%else
%    imseq = [];
%end
