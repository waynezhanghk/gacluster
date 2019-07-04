function gac_demo()
%GAC_DEMO Run GACluster demos
%   GAC_DEMO runs all clustering demos in a row. 
%   Edit this file to see a list of the available demos, 
%   or look into the examples directory.

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

demo_path = fullfile(gac_root, 'examples') ;
addpath(demo_path) ;

tic;
% demo_mnist_full();
demo_mnist_test();
demo_usps();
% demo_fashion_mnist();
toc;

rmpath(demo_path);

end
