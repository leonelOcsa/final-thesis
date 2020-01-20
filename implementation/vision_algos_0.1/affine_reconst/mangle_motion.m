function [mot3, str3,intr3] = mangle_motion(imgs, mot, intr, str, intr_spec, plot_yn)

m = length(mot);
mot3 = mot;
str3 = str;
intr3 = intr;
%intr_spec = zeros(size(intr));

cam_cents = [];
  for i = 1:m,
    cam_cents = [cam_cents, (mot{i}{2})];
  end

  dists = sum(diff(cam_cents')'.^2).^.5;
  [slask, idx] = max(dists);
%keyboard
[idx,dists(idx)]

  mot{idx+1} = mot{idx};
  [intr3, mot3, str3] = bundle_eucl(imgs, mot, intr, str, intr_spec, 2, 1e-2);

  if nargin==6,
    plot_scene(mot3, str3, [2 3], imgs{i}(1,:), i)
  end


