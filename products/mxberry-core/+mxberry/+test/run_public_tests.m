% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
function [testResultWrapper,matlabTestResult]=run_public_tests(varargin)
testResultRecPlugin=...
    mxberry.unittest.TestResultWithStatsRecorderPlugin();
%
runner=matlab.unittest.TestRunner.withNoPlugins;
runner.addPlugin(testResultRecPlugin);
suite=matlab.unittest.TestSuite.fromPackage('mxberry',...
    'IncludingSubpackages',true);
%
matlabTestResult=runner.run(suite);
testResultWrapper=testResultRecPlugin.getTestResultsWrapper();
