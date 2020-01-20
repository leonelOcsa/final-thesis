function C = mkchooser(spec_col)
  unique(spec_col(find(spec_col>=2)));
  width = length(find(spec_col==1))+length(ans);
  C = zeros(length(spec_col), width);
  cur_col = 1;
  for i=1:size(C,1),
    if spec_col(i)==2, C(i,1)=1;
    elseif spec_col(i)==1, C(i,cur_col)=1; cur_col = cur_col + 1;
    end
  end

