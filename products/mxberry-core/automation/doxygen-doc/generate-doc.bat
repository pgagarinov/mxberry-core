set locDir=%~dp0
REM reset error level
type nul>nul
if exist "%locDir%..\..\..\..\docs" rmdir /s /q "%locDir%..\..\..\..\docs"
if errorlevel 1 (
   exit /b %errorlevel%
)

xcopy /f /y "%locDir%README.md" "%locDir%..\..\..\..\README.md"
if errorlevel 1 (
   exit /b %errorlevel%
)

python %locDir%prep4doxymat.py %locDir%..\.. %locDir%..\..\..\..\TTD\mxberry-core-doxygen-prep %locDir%..\..\..\..\TTD\mxberry-core-doxygen-garbage
if errorlevel 1 (
   exit /b %errorlevel%
)

for /f %%i in ('cd') do set curDir=%%i
if errorlevel 1 (
   exit /b %errorlevel%
)

cd %locDir%
if errorlevel 1 (
   exit /b %errorlevel%
)

doxygen
if errorlevel 1 (
   exit /b %errorlevel%
)

echo "">%locDir%..\..\..\..\docs\.nojekyll
if errorlevel 1 (
   exit /b %errorlevel%
)

cd %curDir%
if errorlevel 1 (
   exit /b %errorlevel%
)