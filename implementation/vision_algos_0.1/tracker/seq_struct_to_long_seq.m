function imgs = seq_struct_to_long_seq(img_seqs)

nb_seqs = length(img_seqs)):
seq_lengthes = zeros(nb_seqs,1);
for i = 1:nb_seqs,
  seq_lengthes(i) = length(img_seqs{i});
end

imgs = cell(sum(seq_lengthes), 1);

seq_pointers = cumsum(seq_lengthes); seq_pointers = [1; seq_pointers];

for i = 1:nb_seqs,
  for j = 0:length(img_seqs{i}),
    
  end
end


%finally swap last img in seq 1 with last img in all seqs

