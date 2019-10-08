:SETUP
cd /D "%~dp0"
set EXPECTED_OUTPUT="%tmp%\infrabuild\installer\PowerToysSetup\x64\Release"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
REM set MSBUILD_EXE="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\15.0\Bin\MSBuild.exe"
REM pushd

REM :COPYSOURCE
REM dir
call robocopy ..\installer %tmp%\infrabuild\installer /s
call robocopy ..\x64 %tmp%\infrabuild\x64 /s
call robocopy .. %tmp%\infrabuild License.rtf
call robocopy ../src %tmp%\infrabuild\src /s
REM if errorlevel 7 goto FAIL

dir %tmp%
dir %tmp%\infrabuild
dir %tmp%\infrabuild\x64
REM pushd %tmp%\infrabuild

:BUILD

REM call msbuild ../installer/PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

call msbuild %tmp%\infrabuild\installer\PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

dir %tmp%\infrabuild\installer\PowerToysSetup
dir %tmp%\infrabuild\installer\PowerToysSetup\x64
dir %tmp%\infrabuild\installer\PowerToysSetup\x64\Release

:CHECKRESULTS
echo Expected Output: %EXPECTED_OUTPUT%

if not exist %EXPECTED_OUTPUT% (
  dir
  echo NO build output folder
  goto FAIL
)

:COPYOUTPUT
REM popd
call robocopy %tmp%\infrabuild\installer\PowerToysSetup\x64 ..\installer\PowerToysSetup\x64 /s

:NORMALFINISH
REM ::errorlevel greater than 7 - is intentional. see
REM :: https://blogs.technet.microsoft.com/deploymentguys/2008/06/16/robocopy-exit-codes/
REM ::for more details

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
