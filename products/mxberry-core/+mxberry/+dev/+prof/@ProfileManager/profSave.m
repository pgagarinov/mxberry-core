function profSave(SProfileInfo, dirName)
% PROFSAVE does the same as the built-in `profsave` function except for
% displaying the saved report in the browser.
%
% Input:
%   regular:
%       SProfileInfo: struct[1,1] - structure generated by profile('info')
%           call
%   optional:
%       dirName: char[1,] - name of directory for storing the profiling
%           results in form of a set of HTML files. If not specified
%           "profile_results" subdirectory of current directory is used.
%% $Author: Peter Gagarinov, PhD <pgagarinov@gmail.com> $
% $Copyright: 2015-2016 Peter Gagarinov, PhD
%             2015 Moscow State University,
%            Faculty of Computational Mathematics and Computer Science,
%            System Analysis Department$
%
import mxberry.core.throwerror;
if nargin < 2
    dirName = 'profile_results';
end
%
pathStr = fileparts(dirName);
%
if isempty(pathStr)
    fullDirname = fullfile(cd,dirName);
else
    fullDirname = dirName;
end
%
if ~mxberry.io.isdir(fullDirname)
    mxberry.io.mkdir(dirName);
end
%
for iFunc = 0:numel(SProfileInfo.FunctionTable)
    htmlStr = profview(iFunc,SProfileInfo);
    
    htmlStr = regexprep(htmlStr,'<a href="matlab: profview\((\d+)\);">',...
        '<a href="file$1.html">');
    %
    htmlStr = regexprep(htmlStr,'<a href="matlab:.*?>(.*?)</a>','$1');
    %
    htmlStr = regexprep(htmlStr,'<form.*?</form>','');
    %
    insertStr = ['<body bgcolor="#F8F8F8"><strong>',...
        'This is a static copy of a profile report</strong><p>' ...
        '<a href="file0.html">Home</a><p>'];
    htmlStr = strrep(htmlStr,'<body>',insertStr);
    %
    fileName = fullfile(fullDirname,sprintf('file%d.html',iFunc));
    [idFile,errMsg] = fopen(fileName,'w','n','utf8');
    if idFile > 0
        fprintf(idFile,'%s',htmlStr);
        fclose(idFile);
    else
        throwerror('unableToOpenFile',...
            'Unable to open file %s, reason: %s',fileName,errMsg);
    end
end