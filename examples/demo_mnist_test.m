function demo_mnist_test()
%Clustering demo on MNIST test dataset.

run(fullfile(fileparts(mfilename('fullpath')),...
  '..', 'toolbox', 'gac_setup.m')) ;

[images, labels] = load_data('mnist-test');
K = 20;

images = single(images);
images = bsxfun(@minus, images, mean(images, 2));
images = bsxfun(@times, images, 1 ./ sqrt(sum(images.^2, 1)));
% squared euclidean
dist_mat = sqdist_pw(images, images);
clear images

groupNumber = length(unique(labels(:)));

tic;
cluster_labels = gac_cluster(dist_mat, groupNumber, 'degree', K);
toc;

gac_eval(labels, cluster_labels);

end
