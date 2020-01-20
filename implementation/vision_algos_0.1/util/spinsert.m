function G = spinsert(S, A, r, c)
%function G = spinsert(S, A, r, c)
[dim1, dim2] = size(S);

G = -1;

if issparse(S),

try %try catch block because matlab lacks spfind
  [Sidx1, Sidx2, Sv, dim1, dim2] = spfind(S);
catch
  [Sidx1, Sidx2, Sv] = find(S);
end

else
  if isempty(S), disp('Empty matrix S'); return; end  
  if size(S,2)==3,
    disp('S converted from [idx1 idx2 nnzvals] to sparse matrix.\n')
    Sidx1 = S(:,1);
    Sidx2 = S(:,2);
    Sv = S(:,3);
    dim1 = max(Sidx1);
    dim2 = max(Sidx2);
  else
    disp('S converted to sparse matrix')
    S = sparse(S);
    [Sidx1, Sidx2, Sv, dim1, dim2]
  end
end

if ~issparse(A), A = sparse(A); end

try
[Aidx1, Aidx2, Av] = spfind(A);
catch
[Aidx1, Aidx2, Av] = find(A);
end

Gidx1 = [Sidx1; Aidx1 + r - 1];
Gidx2 = [Sidx2; Aidx2 + c - 1];
Gv = [Sv;Av];
if max(Gidx1)>dim1 || max(Gidx2)>dim2,
  disp('Index out of range\n'),
  return;
end

G = sparse(Gidx1, Gidx2, Gv, dim1, dim2);