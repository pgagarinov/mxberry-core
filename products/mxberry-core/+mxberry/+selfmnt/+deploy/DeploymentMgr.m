% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
classdef DeploymentMgr
    methods
        function deploy(self,installDir)
            %
            warning('on','all');            
            %% Set up Java static class path
            classPathFileName=[installDir,filesep,'javaclasspath.txt'];
            %
            javaPathMgr=self.createJavaStaticPathMgr(classPathFileName);
            javaPathMgr.setUp();   
            %
            %% Set up Matlab path
            %
            repoPath=mxberry.io.PathUtils.rmLastPathParts(installDir,1);
            rootDirList={repoPath};
            %
            mxberry.selfmnt.MatlabPathMgr.setUp(rootDirList);
            savepath([installDir,filesep,'pathdef.m']);            
            %% Configure logging 
            mxberry.log.log4j.Log4jConfigurator.configureSimply();
            %% Configure temporary directories
            mxberry.test.TmpDataManager.setRootDir();
        end
    end
    methods (Access=protected)
        function javaPathMgr=createJavaStaticPathMgr(~,classPathFileName)
            javaPathMgr=...
                mxberry.selfmnt.JavaStaticPathMgr(classPathFileName);            
        end
    end
end