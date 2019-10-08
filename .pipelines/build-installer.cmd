:SETUP
cd /D "%~dp0"
set EXPECTED_OUTPUT="..\installer\PowerToysSetup\x64\Release"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
REM set MSBUILD_EXE="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\15.0\Bin\MSBuild.exe"
REM pushd

REM :COPYSOURCE
REM dir
REM call robocopy ..\installer %tmp%\infrabuild\installer /s
REM call robocopy ..\x64 %tmp%\infrabuild\x64 /s
REM call robocopy .. %tmp%\infrabuild License.rtf
REM call robocopy ../src %tmp%\infrabuild\src /s
REM if errorlevel 7 goto FAIL

REM dir %tmp%
REM dir %tmp%\infrabuild
REM dir %tmp%\infrabuild\x64
REM pushd %tmp%\infrabuild

:BUILD

call msbuild ../installer/PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

dir ../installer/PowerToysSetup/
dir ../installer/PowerToysSetup/x64/
dir ../installer/PowerToysSetup/x64/Release

REM call msbuild %tmp%\infrabuild\installer\PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

REM dir %tmp%\infrabuild\installer\PowerToysSetup
REM dir %tmp%\infrabuild\installer\PowerToysSetup\x64
REM dir %tmp%\infrabuild\installer\PowerToysSetup\x64\Release

REM :CHECKRESULTS
REM echo Expected Output: %EXPECTED_OUTPUT%

REM if not exist %EXPECTED_OUTPUT% (
REM   dir
REM   echo NO build output folder
REM   goto FAIL
REM )

REM :COPYOUTPUT
REM popd
REM call robocopy %tmp%\infrabuild\PowerToysSetup\x64\ .\installer\PowerToysSetup\x64 /s

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
