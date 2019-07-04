function root = gac_root()
%GAC_ROOT Get the root path of the GACluster toolbox.
%   GAC_ROOT() returns the path to the GACluster toolbox.

% Copyright (C) 2019 waynezhanghk.
% All rights reserved.
%
% This file is part of the GACluster toolbox and is made available under
% the terms of the BSD license (see the COPYING file).

root = fileparts(fileparts(mfilename('fullpath'))) ;

end