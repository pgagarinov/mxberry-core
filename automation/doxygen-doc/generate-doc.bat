set locDir=%~dp0
rmdir /s /q "%locDir%..\..\doc"
python %locDir%prep4doxymat.py %locDir%..\.. %locDir%..\..\..\mxberry-core-doxygen-prep %locDir%..\..\..\mxberry-core-doxygen-garbage
for /f %%i in ('cd') do set curDir=%%i
cd %locDir%
doxygen
cd %curDir%