function [rec, idx] = get_err(imgs, mot, str)

%function rec = get_err(imgs, mot, str)
%mot needs to be projection matrices

rec = [];
idx = [];

for i = 1:length(mot),
  pt_indices = imgs{i}(1,:);
  idx = [idx, [i*ones(size(pt_indices));pt_indices]];
%  keyboard
  pflat(mot{i}*str(:,pt_indices))-imgs{i}(2:4,:); sum(ans.*ans).^.5;
  rec = [rec,ans];
end
