% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
classdef DiskBasedHashMapFactory
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj=getInstance(varargin)
            obj=mxberry.core.cont.DiskBasedHashMap(varargin{:});
        end
    end
    
end
