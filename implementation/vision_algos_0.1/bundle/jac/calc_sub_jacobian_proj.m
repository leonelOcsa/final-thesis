function J = calc_sub_jacobian_proj(P, str)
  
  
  
  
  J = [];
  
  for i = 1:size(str,2),

    X = str(:,i);
    P3X = (P(3,:)*X);
    

    
    J = [J ;
	 -[X', zeros(1,4), -X'*(P(1,:)*X)/P3X]/P3X
	 -[zeros(1,4), X', -X'*(P(2,:)*X)/P3X]/P3X ];
  end
