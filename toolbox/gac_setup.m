function root = gac_setup()
%GAC_SETUP Setup the GACluster toolbox.
%   GAC_SETUP() function adds the GACluster toolbox to MATLAB path.

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

addpath ~/toolbox/m2html

root = gac_root();
addpath(fullfile(root, 'toolbox')) ;
addpath(fullfile(root, 'toolbox/utils')) ;
addpath(fullfile(root, 'toolbox/utils/ami')) ;
addpath(fullfile(root, 'toolbox/utils/munkres')) ;
addpath(fullfile(root, 'examples')) ;

end
