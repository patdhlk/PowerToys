cd /D "%~dp0"
REM set MSBUILD_EXE="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
call msbuild ../installer/PowerToysSetup.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

dir
cd ..
dir
cd installer
dir
cd PowerToysSetup
dir
cd x64
dir
cd Release
dir

7ZIP a -tzip PowerToysSetup.msi.zip PowerToysSetup.msi