function motveucl = mot_to_vec_eucl(mot)
  
  motveucl = [];
  
  for i = 1:length(mot)
    tmp1 =     mot{i}{1};
    tmp2 = mot{i}{2};
    motveucl =  [motveucl; tmp1; tmp2];
    
  end
  
