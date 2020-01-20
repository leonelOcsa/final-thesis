function J = jac_num(f, x0, args,d) 

%function J = jac_num(f, x0, args,d) 
%J = df/dx at x0
  
    J = [];
    f0 = feval(f,x0,args);
    
    for i = 1:length(x0)
      
      delta = zeros(size(x0));
      delta(i) = d;
      
      J = [J, (feval(f,x0+delta,args) - f0 )/d];
    end
    
    
