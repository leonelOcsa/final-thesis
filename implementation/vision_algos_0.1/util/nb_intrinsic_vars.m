function nb = nb_intrinsic_vars(intrinsic_spec)
nb_free = length(find(intrinsic_spec==1));
nb_const = 0;
for i = 1:5,
  a = unique(intrinsic_spec(:,i));
  nb_const = nb_const + length(find(a>=2));
end
  nb = nb_const + nb_free;
