function new_str = handle_runaways(str)

%keyboard
n = size(str,2);
new_str = str;
str = str(1:3,:);
m0 = mean(str,2);
str_m0 = str - m0*ones(1,n);
[a,b,c] = svd(str_m0*str_m0'); %PCA
d = sum(str_m0.^2).^.5; %distance from cloud center
runaways = find(d>3*b(1,1).^.25);%beyond 3*standard_dev
new_str(1:3,runaways) = m0*ones(1,length(runaways));%set runaways to cloud center
