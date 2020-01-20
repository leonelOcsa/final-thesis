function intrinsics = vec_to_intrinsics(intrv, old_intr, spec)

intrinsics = zeros(size(spec));
%all const params first.
%all free params
%mot params
%str params
intrinsics = old_intr;
cur_pos = 1;
%const params first
for i = 1:5, %for each intrinsic parameter
  cidx = find(spec(:,i)==2);%will be >= 2
  if ~isempty(cidx)
    intrinsics(cidx, i) = intrv(cur_pos);
    cur_pos = cur_pos +1;
  end
end

%free params:
for i = 1:5, 
  cidx = find(spec(:,i)==1);
  if ~isempty(cidx),
%    keyboard
    intrinsics(cidx, i) = intrv(cur_pos:cur_pos+length(cidx)-1);
    cur_pos = cur_pos + length(cidx);
  end
end

