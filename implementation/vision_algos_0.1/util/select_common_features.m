function [x1,x2]=select_common_features(x1_orig, x2_orig)


try
  [x1,x2] = select_common_features_faster(x1_orig, x2_orig);
  return;

catch
  
  x1 = [];
  x2 = [];
  
  cur_pos_x1 = 1;
  cur_pos_x2 = 1;
  
  while cur_pos_x1<=size(x1_orig,2) && cur_pos_x2<=size(x2_orig,2),
    if x1_orig(1, cur_pos_x1) < x2_orig(1, cur_pos_x2),
      cur_pos_x1 = cur_pos_x1+1;
    elseif x1_orig(1, cur_pos_x1) > x2_orig(1, cur_pos_x2)
      cur_pos_x2 = cur_pos_x2+1;
    else
      x1 = [x1, x1_orig(:,cur_pos_x1)];
      x2 = [x2, x2_orig(:,cur_pos_x2)];
      cur_pos_x1 = cur_pos_x1+1;
      cur_pos_x2 = cur_pos_x2+1;
    end %if
  end %while
end %try catch