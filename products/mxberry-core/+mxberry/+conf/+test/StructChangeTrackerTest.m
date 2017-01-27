% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
classdef StructChangeTrackerTest<mxberry.core.struct.StructChangeTracker
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function SInput=patch_001_alpha(SInput)
            SInput.alpha=1;
        end
        function SInput=patch_103_test(SInput)
            SInput.beta=2;
        end
    end
    methods
        function SInput=patch_002_test(~,SInput)
            SInput.beta=3;
        end
    end
    
end
