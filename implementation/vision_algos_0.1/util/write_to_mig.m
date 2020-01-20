function write_to_mig(dir_name, imgs, mot, str, sel_frames)
mkdir_str = ['mkdir ' dir_name];

system(mkdir_str);

write_raw_tracks(imgs, [dir_name '/euclid_0.tks']);


fp = fopen([dir_name '/_baseline.txt'], 'w');
fprintf(fp, '%d\n', length(sel_frames));
for i = 1:length(sel_frames),
  fprintf(fp, '%d\n', sel_frames(i));
end
fclose(fp)


fp = fopen([dir_name '/euclid_0.str'], 'w');
for i=1:size(str,2),
  fprintf(fp,'%d %e %e %e 1\n', i-1, str(1,i), str(2,i), str(3,i));
end
fclose(fp);

fp = fopen([dir_name '/euclid_0.mot'], 'w');
fprintf(fp,'%d\n',length(mot));
for i=1:length(mot),
  P = mot{i};
  fprintf(fp,'4 %d %e %e %e %e %e %e %e %e %e %e %e %e -1 0\n', i-1, P(1,1), P(1,2), P(1,3), P(1,4), P(2,1), P(2,2), P(2,3), P(2,4), P(3,1), P(3,2), P(3,3), P(3,4));
end
fclose(fp);





