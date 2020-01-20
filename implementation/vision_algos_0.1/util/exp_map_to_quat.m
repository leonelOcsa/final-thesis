function q=exp_map_to_quat(v)

v  = [v(1) v(2) v(3)]';
if v == [0 0 0]', q = [0 0 0 0]';, 
else
  nv = norm(v);
  q = [v/nv*sin(nv/2); cos((nv)/2)];
end
