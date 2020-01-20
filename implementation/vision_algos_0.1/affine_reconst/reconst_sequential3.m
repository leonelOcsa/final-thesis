function [mot, X] = reconst_sequential3(imgs)

  m = length(imgs)

  n = imgs{end}(1,length(imgs{end}));

  good_indices = zeros(m,n);
  for i = 1:m,
    good_indices(i,imgs{i}(1,:))=1;
  end

  X = zeros(4,n);
  reconstructed_Xs = zeros(1,n);
  x1_orig = imgs{1};
  x2_orig = imgs{2};

  [x1,x2]= select_common_features(x1_orig, x2_orig);
 
  [mot_init,X_init] = factorization_tomasi_kanade({x1,x2});

  X(:,find(good_indices(1,:).*good_indices(2,:))) = X_init;
  reconstructed_Xs(find(good_indices(1,:).*good_indices(2,:))) = 1;
  mot = cell(m, 1);

  mot{1} = mot_init{1};
  mot{2} = mot_init{2};


  for i = 3:m,
    [cur_reconst_X, cur_reconst_points] = select_common_features([find(reconstructed_Xs);X(:,find(reconstructed_Xs))], imgs{i});

    mot{i} = resec_affine(cur_reconst_X(2:end,:), cur_reconst_points);

    new_reconst_candidates = find(reconstructed_Xs==0);
    [x1,x2]=select_common_features(imgs{i-1}, imgs{i});
    x1 = select_common_features(x1, new_reconst_candidates);
    x2 = select_common_features(x2, new_reconst_candidates);
    if ~isempty(x1)
      X1 = intersect_affine2({mot{i-1}, mot{i}},{x1,x2});
      X1 = [X1; ones(1,size(X1,2))];
      X(:,x1(1,:)) = X1;
      reconstructed_Xs(find(good_indices(i-1,:).*good_indices(i,:))) = 1;
    end
  end

  %and finally check if there is a connection between img m and img 1
  [cur_reconst_X, cur_reconst_points] = select_common_features([find(reconstructed_Xs);X(:,find(reconstructed_Xs))], imgs{1});


  new_reconst_candidates = find(reconstructed_Xs==0);
  [x1,x2]=select_common_features(imgs{m}, imgs{1});

  x1 = select_common_features(x1, new_reconst_candidates);
  x2 = select_common_features(x2, new_reconst_candidates);
  if ~isempty(x1)
    X1 = intersect_affine2({mot{m}, mot{1}},{x1,x2});
    X1 = [X1; ones(1,size(X1,2))];
    X(:,x1(1,:)) = X1;
    reconstructed_Xs(find(good_indices(m,:).*good_indices(1,:))) = 1;
  end

