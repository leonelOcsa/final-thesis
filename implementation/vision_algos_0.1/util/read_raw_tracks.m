function imseq = read_raw_tracks(name)
%function imseq = read_raw_tracks(name)
%

fp = fopen(name, 'r');
if(~(fp<0))
    imseq = [];
    while(feof(fp) == 0)
        tmp = fread(fp, 6, 'int');
        tmp2 = fread(fp, 2, 'double');
        
        if(length(tmp) == 6 & length(tmp2) == 2)
            imseq = [imseq; tmp([3 4])' tmp2'];  
        end
%    tmp([3 4])
    end
    fclose(fp);
else
    imseq = [];
end
