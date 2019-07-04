%GACluster (Graph agglomerative clustering) toolbox
%
% Please cite the following papers if you end up using the code.
%
%    [1] W. Zhang, X. Wang, D. Zhao, and X. Tang. 
%        Graph Degree Linkage: Agglomerative Clustering on a Directed Graph.
%        ECCV 2012.
%    [2] W. Zhang, D. Zhao, and X. Wang. 
%        Agglomerative clustering via maximum incremental path integral.
%        Pattern Recognition, 46 (11): 3056-3065, 2013.
%
% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).
%
%   Clustering:
%     gac_cluster              - Create hierarchical cluster tree with graph agglomerative clustering.
%     gac_createdigraph        - Construct a directed graph from pairwise distance matrix.
%     gac_agglomerge           - Perform cluster merging process with degree affinity.
%     gac_nnmerge              - Merge each vertex with its nearest neighbor to initialize clusters.
%     gac_computeaffinitybatch - Compute the affinity between a cluster and all clusters.
%
%   Evaluation:
%     gac_eval                 - Clustering evaluation.
%
%   Miscellaneous:
%     gac_setup                - Setup the GACluster toolbox.
%     gac_root                 - Get the root path of the GACluster toolbox.
%     gac_demo                 - Run GACluster demos.
