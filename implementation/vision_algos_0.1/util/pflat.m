function P = pflat(P_in)

l = size(P_in,1);
P = P_in*diag(P_in(l,:).^-1);
