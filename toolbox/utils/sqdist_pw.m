function dist_mat = sqdist_pw(X1, X2)

sqs1 = sum(X1 .* X1, 1)';
sqs2 = sum(X2 .* X2, 1);
dist_mat = (-2) * X1' * X2;
dist_mat = bsxfun(@plus, bsxfun(@plus, dist_mat, sqs2), sqs1);

end