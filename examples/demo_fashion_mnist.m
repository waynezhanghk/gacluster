function demo_fashion_mnist(pca_ratio)
%Clustering demo on Fashion-MNIST.

run(fullfile(fileparts(mfilename('fullpath')),...
  '..', 'toolbox', 'gac_setup.m')) ;

[images, labels] = load_data('fashion-mnist');
K = 100;
if nargin < 1
    pca_ratio = 0.9;
end

images = single(images);
images = apply_pca(images, pca_ratio);
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
