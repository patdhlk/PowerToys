:SETUP
cd /D "%~dp0"
set EXPECTED_OUTPUT="installer\PowerToysSetup\x64\Release"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
REM pushd

REM :COPYSOURCE
REM dir
REM call robocopy ..\installer\ %tmp%\infrabuild\ /s
REM call robocopy ..\x64 %tmp%\infrabuild /s
REM if errorlevel 7 goto FAIL

REM dir %tmp%
REM pushd %tmp%\infrabuild

:BUILD

call msbuild ../installer/PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

cd ../installer/PowerToysSetup
dir
cd x64
dir
cd Release
dir

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

REM :NORMALFINISH
REM ::errorlevel greater than 7 - is intentional. see
REM :: https://blogs.technet.microsoft.com/deploymentguys/2008/06/16/robocopy-exit-codes/
REM ::for more details

REM if errorlevel 7 goto FAIL

REM echo Build SUCCEEDED.
REM set exit_code=0

REM goto END

REM :FAIL
REM echo Build FAILED.
REM set exit_code=1

REM :END
REM echo popd
REM popd
