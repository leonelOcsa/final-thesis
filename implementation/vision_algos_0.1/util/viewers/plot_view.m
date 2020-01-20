function plot_view(imgs, seq, str, idx)

all_pts = pflat(seq{idx}*str);
figure; hold off; plot(all_pts(1,:), all_pts(2,:),'r*');
pt_indices = imgs{idx}(1,:);
sel_pts = pflat(seq{idx}*str(:,pt_indices));
hold on; plot(sel_pts(1,:), sel_pts(2,:), 'g*');


