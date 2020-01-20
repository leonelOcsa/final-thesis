function P = gen_pair_mat(O,min_overlap_size)

m = size(O,1);

P = (O>=min_overlap_size).*upper_triang_ones(m);



