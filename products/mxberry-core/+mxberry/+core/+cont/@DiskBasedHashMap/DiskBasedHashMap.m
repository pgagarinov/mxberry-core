% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
classdef DiskBasedHashMap<mxberry.core.cont.ondisk.HashMapMatXML
    methods
        function self=DiskBasedHashMap(varargin)
            self=self@mxberry.core.cont.ondisk.HashMapMatXML(varargin{:});
        end
    end
end

