setlocal
:: Runs all Matlab unit tests for the latest GIT revision and e-mails results
:: 1. archName - string: architecture name, can be either win32 or win64


if "%~1"=="" (
	set archName=win64
) else (
	set archName=%1
)	

if "%~2"=="" (
	set matlabVer=2016b
) else (
	set matlabVer=%2
)	

if "%archName%"=="win64" (
	set matlabBin="C:\Program Files\MATLAB\R%matlabVer%\bin\win64\matlab"
) else if "%archName%"=="win32" (
	set matlabBin="C:\Program Files (x86)\MATLAB\R%matlabVer%\bin\win32\matlab"
) else (
	echo %0: architecture %archName% not supported
	exit /b 1
)	
SET automationDir=%~dp0
set runMarker="win_%JOB_NAME%_%GIT_BRANCH%"
echo runMarker=%runMarker%
set confName="default"
set genericBatScript=%automationDir%\run_matlab_tests.bat
echo genericBatScript=%genericBatScript%
set deploymentDir=%automationDir%..\install
call %genericBatScript% %deploymentDir% mxberry.test.run_tests_remotely %matlabBin% %runMarker% %confName%