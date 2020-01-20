function intrv = intrinsics_to_vec(intrinsics, spec)
%function intrv = intrinsics_to_vec(intrinsics, bundle_spec)
%intrinsics: m x [f a s x y ] matrix containing intrinsic parameters
%bundle_spec: m x 5 matrix containing 0, 1, 2...
% 0: intrinsic param not included in bundle
% 1: param free to vary
% k = 2...m: param constant over all cameras, where same param has spec = k.
% only k = 2 implemented. no check is done whether the params are actually
% equal
m = size(intrinsics, 1);
%all const params first.
%all free params
%mot params
%str params
intrv = [];
%const params first
for i = 1:5, %for each intrinsic parameter
  cidx = find(spec(:,i)>=2);%will be >= 2
  if ~isempty(cidx), intrv = [intrv; intrinsics(cidx(1), i)];  end
end

%free params:
for i = 1:5, 
  cidx = find(spec(:,i)==1);
  if ~isempty(cidx),  intrv = [intrv; intrinsics(cidx, i)]; end 
end
  

