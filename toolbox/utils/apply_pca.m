function images = apply_pca(images, pca_ratio)

[coeff, ~, latent] = pca(images');
eig_num = find(cumsum(latent) / sum(latent) < pca_ratio);
eig_num = eig_num(end);
images = coeff(:, 1:eig_num)' * bsxfun(@minus, images, mean(images, 2));
images = bsxfun(@times, 1 ./ sqrt(latent(1:eig_num)), images);

end
