function cluster_labels = gac_nnmerge(distance_matrix, NNIndex)
%GAC_NNMERGE Merge each vertex with its nearest neighbor to initialize clusters.
%   GAC_NNMERGE() returns the initial clusters for graph agglomerative clustering.
% Input:
%   - distance_matrix: pairwise distances, d_{i -> j}
%	- NNIndex: sorted indices of K nearest neighbors (including self), N x K matrix
% Output:
%   - cluster_labels: asymmetric weighted adjacency matrix of directed graph

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

%% compute NN indices if it does not exist
sample_num = size(distance_matrix,1);
if nargin < 2 || size(NNIndex,1) ~= sample_num || size(NNIndex,2) < 2
    [~, NNIndex] = sort(distance_matrix, 2);
end

%%
% tic;
% cluster_labels = zeros(sample_num, 1);
% counter = 1;
% for i = 1 : sample_num
%     idx = NNIndex(i, 1:2);
%     assignedCluster = cluster_labels(idx);
%     assignedCluster = unique(assignedCluster(assignedCluster > 0));
%     switch length(assignedCluster)
%         case 0
%             cluster_labels(idx) = counter;
%             counter = counter + 1;
%         case 1
%             cluster_labels(idx) = assignedCluster;
%         otherwise
%             cluster_labels(idx) = assignedCluster(1);
%             for j = 2 : length(assignedCluster)
%                 cluster_labels(cluster_labels == assignedCluster(j)) = assignedCluster(1);
%             end
%     end
% end
% toc;

[~, cluster_labels] = graphconncomp(sparse([1:sample_num]', NNIndex(:, 2)', ones(sample_num, 1), sample_num, sample_num), 'Directed', true, 'Weak', true);
cluster_labels = cluster_labels(:);

end
