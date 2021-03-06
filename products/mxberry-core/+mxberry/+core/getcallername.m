function callerName=getcallername(nStepsUp,mode)
% GETCALLERNAME returns a name of caller determined by a number of steps up
% in the call stacks.
%
% Input:
%   optional:
%       nStepsUp: numeric[1,1] - number of steps up in the call stacks,
%           =1 by default
%       mode: char [1,] - may be
%           'default' (default) - callerName equals to the class name in
%               the case of class, otherwise callerName equals to the name
%               of the corresponding function or script
%           'full' - callerName equals either to the name of the
%               corresponding function or script or to the name of class
%               concatenated through '.' with the name of method
%
% Output:
%   callerName: char[1,] - caller name
%
%% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2015 Moscow State University,
%            Faculty of Computational Mathematics and Computer Science,
%            System Analysis Department$
%
import mxberry.core.check.lib.*;
if nargin<1
    nStepsUp=1;
elseif isnumeric(nStepsUp)
    if nStepsUp<0
        mxberry.core.throwerror('wrongInput',...
            'nStepsUp cannot be negative');
    end
else
    error([upper(mfileaname),':wrongInput'],...
        'nStepsUp is expected to be numeric');
end
%
if fix(nStepsUp)~=nStepsUp
    mxberry.core.throwerror('wrongInput',...
        'nStepsUp is expected to be an integer');
end
%
if nargin<2
    mode='default';
else
    mxberry.core.check.checkgen(mode,...
        @(x)(isstring(x)&&~isempty(x)));
end
%
[methodName,className]=mxberry.core.getcallernameext(nStepsUp+1);
if ~strcmpi(mode,'default')||isempty(className)
    % delete info on subfunctions
    curInd=find(methodName=='/'|methodName=='\',1,'first');
    if ~isempty(curInd)
        methodName=methodName(1:curInd-1);
    end
end
switch lower(mode)
    case 'default'
        if isempty(className)
            callerName=methodName;
        else
            callerName=className;
        end
    case 'full'
        if isempty(className)
            callerName=methodName;
        else
            callerName=[className '.' methodName];
        end
    otherwise
        mxberry.core.throwerror('wrongInput',...
            'Unknown mode: %s',mode);
end