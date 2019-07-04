function cluster_labels = gac_cluster(distance_matrix, group_num, method, K)
%GAC_CLUSTER Create hierarchical cluster tree with graph agglomerative clustering
% Input: 
%   - distance_matrix: pairwise distances, d_{i -> j}
%   - group_num: the target number of clusters
%   - method: the choice of agglomerative clustering algorithm
%      'degree'    --- graph degree linkage (default)
%      'average'   --- graph average linkage, unweighted average simiarlity
%                      using edge weights of the graph as similarities
%   - K: the number of nearest neighbors for constructing a KNN graph, default: 20
% Output:
%   - cluster_labels: clustering results

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

%% parse inputs
disp('--------------- Graph Agglomerative Clustering ---------------------');

if nargin < 2, error('GAC: input arguments are not enough!'); end
if nargin < 3, method = 'degree';   end
if nargin < 4, K = 20;   end

%% initialization
disp('--------------------- Creating Directed Graph ---------------------');
[graphW, NNIndex] = gac_createdigraph(distance_matrix, K);

%% agglomerative clustering
disp('--------------------- Nearest Neighbor Merging ---------------------');
initial_cluster_labels = gac_nnmerge(distance_matrix, NNIndex);
clear distance_matrix NNIndex

disp('---------------------- Agglomerative Merging ----------------------');
cluster_labels = gac_agglomerge(graphW, initial_cluster_labels, group_num, method);

end
