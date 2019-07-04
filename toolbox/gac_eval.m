function gac_eval(gt_labels, pred_labels)
%GAC_EVAL Evaluate clustering results with various metrics
% Input: 
%   - gt_labels    - ground-truth cluster assignment
%   - pred_labels  - cluster assignment by algorithm

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

gt_labels = map_positive(gt_labels);
pred_labels = map_positive(pred_labels);

score_nmi = cluster_eval(gt_labels, pred_labels, 'nmi');
score_acc = cluster_eval(gt_labels, pred_labels, 'acc');
score_ari = cluster_eval(gt_labels, pred_labels, 'ari');
fprintf('Normalized Mutual Information: %.3f\n', round(score_nmi, 3));
fprintf('Clustering Accuracy: %.3f\n', round(score_acc, 3));
fprintf('Adjusted Rand Index: %.3f\n', round(score_ari, 3));

end

function out = cluster_eval(gt_labels, pred_labels, method)
% clustering evaluation with various metrics.

assert(nargin == 3);
assert(numel(gt_labels) == numel(pred_labels));
if min(size(gt_labels)) > 1 || min(size(pred_labels)) > 1
   error('First two arguments must be two vectors with the same length.');
end
num = numel(gt_labels);
    
switch lower(method)
    case {'adjustedrandindex', 'adjustedri', 'adjustri', 'ari'}
        out = adjrand(pred_labels, gt_labels);
    case 'ami'
        [out, ~] = ami(gt_labels, pred_labels);
    case 'nmi'
        x = reshape(gt_labels,1,[]);
        y = reshape(pred_labels,1,[]);
        l = min(min(x),min(y));
        x = x-l+1;
        y = y-l+1;
        k = max(max(x),max(y));
        idx = 1:num;
        Mx = sparse(idx,x,1,num,k,num);
        My = sparse(idx,y,1,num,k,num);
        Pxy = nonzeros(Mx'*My/num); %joint distribution of x and y
        Hxy = -dot(Pxy,log2(Pxy));
        % hacking, to elimative the 0log0 issue
        Px = nonzeros(mean(Mx,1));
        Py = nonzeros(mean(My,1));
        % entropy of Py and Px
        Hx = -dot(Px,log2(Px));
        Hy = -dot(Py,log2(Py));
        % mutual information
        MI = Hx + Hy - Hxy;
        % normalized mutual information
        z = sqrt((MI/Hx)*(MI/Hy));
        out = max(0,z);
    case {'accuracy', 'acc'}
        unique_gt_labels = unique(gt_labels);
        unique_pred_labels = unique(pred_labels);
        gt_indicator = bsxfun(@eq, gt_labels(:), unique_gt_labels(:)');
        pred_indicator = bsxfun(@eq, pred_labels(:), unique_pred_labels(:)');
        cost_matrix = single(pred_indicator)'*single(gt_indicator);
        [col_ind, ~] = munkres(max(cost_matrix(:)) - cost_matrix);
        pred_labels = arrayfun(@(x) unique_gt_labels(col_ind(x)), pred_labels);
        out = sum(pred_labels == gt_labels) / length(pred_labels);
end

end

function out_labels = map_positive(labels)
% force cluster labels to be positive consecutive numbers

out_labels = zeros(size(labels));
unique_labels = unique(labels);
for i = 1 : length(unique_labels)
    out_labels(labels == unique_labels(i)) = i;
end
assert(all(out_labels > 0));

end
