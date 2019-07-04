function cluster_labels = gac_agglomerge(graphW, initial_cluster_labels, group_num, method)
%GAC_AGGLOMERGE Perform cluster merging process with degree affinity
% Input:
%   - graphW: asymmetric weighted adjacency matrix of directed graph
%   - initial_cluster_labels: an initial vector of cluster labels
%   - group_num: the target number of clusters
% Output:
%   - cluster_labels: a vector of cluster labels whose entries are group indices. 

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

%% param check
sample_num = size(graphW,1);
my_inf = 1e10;
if sample_num ~= size(initial_cluster_labels, 1) || size(initial_cluster_labels, 2) ~= 1
    error('GACluster: Invalid size of initial_cluster_labels');
end

%% initialization
VERBOSE = true;

unique_labels = unique(initial_cluster_labels);
cluster_num = length(unique_labels);
if cluster_num <= group_num
    error('GACluster: Too few initial clusters. No need to merge!');
end

initial_clusters = cell(cluster_num,1);
for i = 1 : cluster_num
    initial_clusters{i} = find(initial_cluster_labels(:) == unique_labels(i));
end
cluster_size = cellfun(@length, initial_clusters);
clear unique_labels

%% compute initial (negative) affinity table (upper trianglar matrix), very slow
if VERBOSE
    disp('   Computing initial table.' );
end
[aff_table, asym_aff_table] = gac_init_aff_table (graphW, initial_clusters, cluster_size, method);
aff_table = tril(my_inf*ones(cluster_num)) - aff_table;

if VERBOSE
    disp('   Starting merging process');
end

active_group_num = cluster_num;
while true 
    if mod(active_group_num, 100) == 0 && VERBOSE
        disp(['   Group count: ' num2str(active_group_num)]);
    end
    % Find two clusters with the largest affinity
    [~, min_index1, min_index2] = gac_partial_min_triu(aff_table, active_group_num);  % the indices are sorted

    % Merge the second cluster to the first cluster
    initial_clusters{min_index1} = unique([initial_clusters{min_index1}; initial_clusters{min_index2}]);
    cluster_size(min_index1) = length(initial_clusters{min_index1});
    asym_aff_table(1:active_group_num, min_index1) = asym_aff_table(1:active_group_num, min_index1) + asym_aff_table(1:active_group_num, min_index2);
    if (min_index2 ~= active_group_num)
        % Copy the last cluster to the position of the second cluster
        initial_clusters{min_index2} = initial_clusters{end};
        cluster_size(min_index2) = cluster_size(active_group_num);
        % Note that aff_table is an upper triangular matrix
        aff_table(1:min_index2-1, min_index2) = aff_table(1:min_index2-1, active_group_num);
        aff_table(min_index2, min_index2+1:active_group_num-1) = aff_table(min_index2+1:active_group_num-1, active_group_num);
        asym_aff_table(1:active_group_num, min_index2) = asym_aff_table(1:active_group_num, active_group_num);
        asym_aff_table(min_index2, 1:active_group_num) = asym_aff_table(active_group_num, 1:active_group_num);
    end
    % Destroy the original position of the last cluster
    initial_clusters(end) = [];
    aff_table(:,active_group_num) = my_inf;
    aff_table(active_group_num,:) = my_inf;
    active_group_num = active_group_num - 1;
    if active_group_num <= group_num
        break;
    end

    % Recompute the affinity table for the merged cluster
    if isequal(lower(method), 'degree')
        asym_aff_table(min_index1, 1:active_group_num) = gac_computeaffinitybatch (graphW, initial_clusters, min_index1, method);
        aff_table(1:min_index1-1, min_index1) = - asym_aff_table(min_index1, 1:min_index1-1)' - asym_aff_table(1:min_index1-1, min_index1);
        aff_table(min_index1, min_index1+1:active_group_num) = - asym_aff_table(min_index1, min_index1+1:active_group_num) - asym_aff_table(min_index1+1:active_group_num, min_index1)';
    else
        asym_aff_table(min_index1, 1:active_group_num) = asym_aff_table(1:active_group_num, min_index1);
        aff_table_1 = - asym_aff_table(1:active_group_num, min_index1) ./ (length(initial_clusters{min_index1}) * cluster_size(1:active_group_num));
        aff_table(1:min_index1-1, min_index1) = aff_table_1(1:min_index1-1);
        aff_table(min_index1, min_index1+1:active_group_num) = aff_table_1(min_index1+1:active_group_num);
    end
end

%% generate sample labels
cluster_labels = ones(sample_num,1);
for i = 1:length(initial_clusters)
    cluster_labels(initial_clusters{i}) = i;
end
if VERBOSE
    disp(['   Final group count: ' num2str(active_group_num)]);
end

end

function [aff_table, asym_aff_table] = gac_init_aff_table (graphW, initial_clusters, cluster_size, method)

cluster_num = length(initial_clusters);
asym_aff_table = zeros(cluster_num, cluster_num);
for i = 1 : cluster_num
    asym_aff_table(i, :) = gac_computeaffinitybatch (graphW, initial_clusters, i, method);
end
if isequal(lower(method), 'degree')
    aff_table = asym_aff_table + asym_aff_table';
else
    aff_table = bsxfun(@times, bsxfun(@times, asym_aff_table, 1 ./ cluster_size), 1 ./ cluster_size');
end

end

function [minV, min_index1, min_index2] = gac_partial_min_triu(aff_table, active_group_num)

% Find two clusters with the largest affinity
[minAff, min_index1] = min(aff_table(1:active_group_num, 1:active_group_num), [], 1);
[minV, min_index2] = min(minAff);
min_index1 = min_index1(min_index2);
assert(min_index1 < min_index2);

end
