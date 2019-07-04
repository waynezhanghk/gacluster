function [graphW, NNIndex] = gac_createdigraph(distance_matrix, K)
%GAC_CREATEDIGRAPH Construct a directed graph from pairwise distance matrix
% Input:
%   - distance_matrix: pairwise distances, d_{i -> j}
%   - K: the number of nearest neighbors for constructing a KNN graph
% Output:
%   - graphW: asymmetric weighted adjacency matrix of directed graph
%	- NNIndex: sorted indices of K nearest neighbors (including self), N x K matrix

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

%% NN indices
N = size(distance_matrix,1);
% find 2*K NNs in the sense of given distances
% [sortedDist,NNIndex] = sort(distance_matrix,2);
[sortedDist,NNIndex] = mink(distance_matrix, K+1, 2);
sortedDist = sortedDist(:, 1:K+1);
NNIndex = NNIndex(:,1:K+1);

%% estimate derivation
sig2 = sortedDist(:,floor(K/2)+1);
% sig2 = sortedDist(:,80+1);
disp(['  sigma = ' num2str(sqrt(mean(sig2)))]);

%% build graph
sig2 = double(sig2);
ND = double(sortedDist(:, 2:K+1));
clear sortedDist
ND = bsxfun(@times, ND, 1 ./ (2 * sig2));
ND = exp(- ND);
% ND = bsxfun(@times, exp(- ND), 1 ./ sqrt(sig2));
NI = double(NNIndex(:, 2:K+1));
XI = double(repmat([1:N]', 1, K));
graphW = sparse(XI(:),NI(:),ND(:), N, N);
clear XI NI ND sortedDist
% graphW = full(graphW);
graphW(1:N+1:end) = 1;
graphW = bsxfun(@times, graphW, 1 ./ sqrt(sig2));

end
