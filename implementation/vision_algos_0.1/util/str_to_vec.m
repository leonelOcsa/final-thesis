function strv = str_to_vec(str)

  
  str_tmp1 = pflat(str); %cumbersome syntax for matlab compatibility
  str_tmp2 = str_tmp1(1:3,:);
  strv = str_tmp2(:);
