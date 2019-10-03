:SETUP
set EXPECTED_OUTPUT="PowerToysSetup/x64/Release"
pushd

:COPYSOURCE
call robocopy ../installer/ %tmp%/infrabuild/ /s
if errorlevel 7 goto FAIL

pushd %tmp%/infrabuild

:BUILD
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
call msbuild PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

:CHECKRESULTS
echo Expected Output: %EXPECTED_OUTPUT%

if not exist %EXPECTED_OUTPUT% (
  echo NO build output folder
  goto FAIL
)

:COPYOUTPUT
popd
call robocopy %tmp%/infrabuild/PowerToysSetup/x64/ ./installer/PowerToysSetup/x64 /s

:NORMALFINISH
::errorlevel greater than 7 - is intentional. see
:: https://blogs.technet.microsoft.com/deploymentguys/2008/06/16/robocopy-exit-codes/
::for more details

if errorlevel 7 goto FAIL

echo Build SUCCEEDED.
set exit_code=0

goto END

:FAIL
echo Build FAILED.
set exit_code=1

:END
echo popd
popd
