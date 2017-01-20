#!/bin/bash
# Runs all Matlab unit tests for the latest GIT revision and e-mails results
scriptName=`basename $0` #script name
automationDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
genericBatScript=$automationDir/run_matlab_tests.sh
echo genericBatScript=$genericBatScript
deploymentDir=$automationDir/../install
echo deploymentDir=$deploymentDir
#
echo ===== run_tests_remotely started: `date` =====
if [ $# -eq 0 ]
then
	echo matlabVer is obligatory argument
else
	matlabVer=$1
fi
#
matlabBin=/usr/local/MATLAB/R$matlabVer/bin/matlab
#
runMarker=linux_${JOB_NAME}_${GIT_BRANCH}
$genericBatScript $deploymentDir mxberry.test.run_tests_remotely $matlabBin $runMarker default
