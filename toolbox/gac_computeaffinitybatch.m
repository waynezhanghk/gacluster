function L = gac_computeaffinitybatch (graphW, clusters, i, method)
%GAC_COMPUTEAFFINITYBATCH Compute the affinity between a cluster and all clusters
% Input:
%   - graphW: asymmetric weighted adjacency matrix of directed graph
%   - clusters: index vectors of all clusters
%   - i: the index of some cluster
% Output:
%   - L: the directed affinity of cluster i and all clusters.

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

num_cluster = length(clusters);
num_i = numel(clusters{i});

L = zeros(1, num_cluster);
if isequal(lower(method), 'degree')
    deg_prod = sum(graphW(clusters{i}, :), 1) .* sum(graphW(:, clusters{i}), 2)';
else
    deg_prod = sum(graphW(clusters{i}, :), 1);
end
for j = 1 : num_cluster
    if j ~= i
        L(j) = sum(deg_prod(clusters{j}));
    end
end
if isequal(lower(method), 'degree')
    L = L / (num_i*num_i);
end

end
