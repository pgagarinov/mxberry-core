classdef Log4jConfigurator<mxberry.log.log4j.Log4jConfigurator
    %LOG4JCONFIGURATOR simplifies log4j configuration, especially when
    %Parallel Computing Toolbox is used. In the latter case the class forwards
    %the logs of different processees in separate log files
    %
    % $Author: Peter Gagarinov  <pgagarinov@gmail.com> $	$Date: 2011-05-18 $
    % $Copyright: Moscow State University
    %            Faculty of Computational Mathematics and Computer Science
    %            System Analysis Department 2011 $
    properties (Constant)
        %
        MASTER_LOG_FILE_NAME='master';
        CHILD_LOG_FILE_NAME_PREFIX='child';
        LOG_FILE_EXT=sprintf('log.%d-%02d-%02d-%02d-%02d-%02.0f',datevec(now));
        MAIN_LOG_FILE_PREFIX='main.';
    end
    properties(Constant)
        SP_MAIN_LOG_FILE_NAME='mxberry.testrunner.log4j.logfile.main.name'
        SP_CUR_PROCESS_NAME='mxberry.testrunner.log4j.curProcessName'
        SP_LOG_DIR_WITH_SEP='mxberry.testrunner.log4j.logfile.dirwithsep'
        SP_LOG_FILE_EXP='mxberry.testrunner.log4j.logfile.ext'
        CONF_REPO_MGR_CLASS=...
            'mxberry.test.conf.AdaptiveConfRepoManager';
    end
    methods (Access=private)
        function self=Log4jConfigurator()
        end
    end
    methods (Static)
        function configure(confSource,varargin)
            % CONFIGURE performs log4j configuration
            %
            self=mxberry.test.log.Log4jConfigurator();
            if isa(confSource,self.CONF_REPO_MGR_CLASS)
                if ~confSource.isParam('logging.log4jSettings')
                    mxberry.core.throwerror('wrongConfVersion',...
                        'Consider updating your configuration');
                end
                %
                logPropStr=confSource.getParam(...
                    'logging.log4jSettings');
            else
                mxberry.core.throwerror('wrongInput',...
                    ['configuration source should be either ',...
                    'a property string or a reference',...
                    'to ',self.CONF_REPO_MGR_CLASS,' object']);
            end
            self.configureInternal(logPropStr,varargin{:});
        end
        function logFileName=getMainLogFileName()
            self=mxberry.test.log.Log4jConfigurator();
            logFileName=self.getMainLogFileNameInternal();
        end
    end
end
