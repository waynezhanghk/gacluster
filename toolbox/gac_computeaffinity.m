function [L_i, L_j] = gac_computeaffinity (graphW, cluster_i, cluster_j)
%GAC_COMPUTEAFFINITY Compute the directed affinity between two clusters
% Input:
%   - graphW: asymmetric weighted adjacency matrix of directed graph
%   - cluster_i: index vector of cluster i
%   - cluster_j: index vector of cluster j
% Output:
%   - L_i: the first part of affinity of cluster i and j.
%   - L_j: the second part of affinity of cluster i and j.

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

num_i = numel(cluster_i);
num_j = numel(cluster_j);

L_ij = graphW(cluster_i, cluster_j);
L_ji = graphW(cluster_j, cluster_i);
L_i = sum(L_ij,1)*sum(L_ji,2) / (num_i*num_i);
L_j = sum(L_ji,1)*sum(L_ij,2) / (num_j*num_j);
% L_ij = L_i + L_j;

end
