% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2012-2015 Moscow State University,
%            Faculty of Applied Mathematics and Computer Science,
%            System Analysis Department$
function [htmlOut,fullFileNameList,reportList]=...
    scanWithHtmlReport(dirList,patternToExclude)
[fullFileNameList,reportList]=...
    mxberry.dev.MLintScanner.scan(dirList,...
    patternToExclude);
[~,fileList]=cellfun(@fileparts,fullFileNameList,'UniformOutput',false);
%
SHtmlProxyReportVec = [];
reportName = 'MLint-MXBerry Code Analyzer Report';
%
nFiles=numel(fullFileNameList);
for iFile = 1:nFiles
    %
    SHtmlProxyReportVec(iFile).fileName = fileList{iFile}; %#ok<*AGROW>
    SHtmlProxyReportVec(iFile).fullFileName = fullFileNameList{iFile};
    %
    SHtmlProxyReportVec(iFile).lineNumber = [];
    SHtmlProxyReportVec(iFile).lineMessage = {};
    %
    SMlintProblemVec = reportList{iFile};
    for iProblem = 1:numel(SMlintProblemVec)
        ln = SMlintProblemVec(iProblem).message;
        ln = code2html(ln);
        for iLine = 1:numel(SMlintProblemVec(iProblem).line)
            SHtmlProxyReportVec(iFile).lineNumber(end+1) = ...
                SMlintProblemVec(iProblem).line(iLine);
            SHtmlProxyReportVec(iFile).lineMessage{end+1} = ln;
        end
    end
    %
    % Now sort the list by line number
    if ~isempty(SHtmlProxyReportVec(iFile).lineNumber)
        lineNum = [SHtmlProxyReportVec(iFile).lineNumber];
        lineMsg = SHtmlProxyReportVec(iFile).lineMessage;
        [~, ndx] = sort(lineNum);
        lineNum = lineNum(ndx);
        lineMsg = lineMsg(ndx);
        SHtmlProxyReportVec(iFile).lineNumber = lineNum;
        SHtmlProxyReportVec(iFile).lineMessage = lineMsg;
    end
    
end
%
% Limit the number of messages displayed to keep from being overwhelmed by
% large pathological files.
DISPLAY_LIMIT = 500;
%
% Now generate the HTML
dirListExpr=mxberry.core.cell.cellstr2expression(dirList);
rerunAction = sprintf(...
    'mxberry.dev.MLintScanner.scanWithHtmlReport(%s,''%s'')',...
    dirListExpr,patternToExclude);
s = makeReportHeader(reportName, rerunAction);
%
s{end+1} = '<table cellspacing="0" cellpadding="2" border="0">';
for n = 1:length(SHtmlProxyReportVec)
    encodedFileName = urlencode(SHtmlProxyReportVec(n).fullFileName);
    decodedFileName = urldecode(encodedFileName);
    %
    s{end+1} = '<tr><td valign="top" class="td-linetop">';
    openInEditor = sprintf('edit(''%s'')',decodedFileName);
    regExpRep = sprintf('%s', SHtmlProxyReportVec(n).fileName);
    %
    s{end+1} = ['<a href="matlab:'  openInEditor '">'];
    s{end+1} = sprintf('<span class="mono">');
    s{end+1} = regExpRep;
    s{end+1} = sprintf('</span> </a> </br>');
    %
    if isempty(SHtmlProxyReportVec(n).lineNumber)
        msgStr = '<span class="soft"> No Messages </span>';
    elseif length(SHtmlProxyReportVec(n).lineNumber)==1
        msgStr = '<span class="warning"> 1 message </span>';
    elseif length(SHtmlProxyReportVec(n).lineNumber) < DISPLAY_LIMIT
        msgStr = ['<span class="warning">',...
            sprintf('%d messages',length(SHtmlProxyReportVec(n).lineNumber)),...
             '</span>'];
    else
        % Truncate the list of messages if there are too many.
        msgStr = ['<span class="warning">',...
            sprintf('%d messages',length(SHtmlProxyReportVec(n).lineNumber)), ...
            '\n<br/>'  ...
            sprintf('Showing only first %d',DISPLAY_LIMIT),'</span>'];
    end
    s{end+1} = sprintf('%s</td><td valign="top" class="td-linetopleft">',msgStr);
    %
    if ~isempty(SHtmlProxyReportVec(n).lineNumber)
        for m = 1:min(length(SHtmlProxyReportVec(n).lineNumber),DISPLAY_LIMIT)
            
            openMessageLine = sprintf('opentoline(''%s'',%d)',...
                decodedFileName, SHtmlProxyReportVec(n).lineNumber(m));
            %
            lineNum = sprintf('%d', SHtmlProxyReportVec(n).lineNumber(m));
            lineMsg =  sprintf('%s',SHtmlProxyReportVec(n).lineMessage{m});
            %
            s{end+1} = sprintf('<span class="mono">');
            s{end+1} = ['<a href="matlab:' openMessageLine '">'];
            s{end+1} = lineNum;
            s{end+1} = sprintf('</a> ');
            s{end+1} = lineMsg;
            s{end+1} = sprintf('</span> <br/>');
        end
    end
    s{end+1} = '</td></tr>';
end
%
s{end+1} = '</table>';
s{end+1} = '</body></html>';
%
if nargout==0
    sOut = [s{:}];
    web(['text://' sOut],'-noaddressbox');
else
    htmlOut = s;
end
end
function htmlOut = makeReportHeader( reportName,rerunAction)
htmlOut = {};

%% XML information
h1 = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
h2 = '<html xmlns="http://www.w3.org/1999/xhtml">';
encoding = 'UTF-8';
h3 = sprintf('<head><meta http-equiv="Content-Type" content="text/html; charset=%s" />',encoding);
%% Add cascading style sheet link
reportdir = fullfile(matlabroot,'toolbox','matlab','codetools','+internal','+matlab','+codetools','+reports');
cssfile = fullfile(reportdir,'matlab-report-styles.css');
h4 = sprintf('<link rel="stylesheet" href="file:///%s" type="text/css" />', cssfile);

jsfile = fullfile(reportdir,'matlabreports.js');
h5 = sprintf('<script type="text/javascript" language="JavaScript" src="file:///%s"></script>',jsfile);

%% HTML header
htmlOut{1} = [h1 h2 h3 h4 h5];

htmlOut{2} = sprintf('<title>%s</title>', reportName);
htmlOut{3} = '</head>';
htmlOut{4} = '<body>';
htmlOut{5} = sprintf('<div class="report-head">%s</div><p>', reportName);


%% Descriptive text
htmlOut{end+1} = '<table border="0"><tr>';
htmlOut{end+1} = '<td>';
htmlOut{end+1} = sprintf('<input type="button" value="%s" id="rerunThisReport" onclick="runreport(''%s'');" />',...
'Rerun This Report', escape(rerunAction));
    htmlOut{end+1} = '</td>';
end
function escapedAction = escape(action)
    escapedAction = regexprep(action,'[\\'']','\\$0');
    char(com.mathworks.mlwidgets.html.HTMLUtils.encodeUrl(escapedAction));
end