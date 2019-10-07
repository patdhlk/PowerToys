cd /D "%~dp0"

dir "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7"
dir "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\"
dir "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\15.0"
dir "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current"
dir "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\15.0\Bin"


set MSBUILD_EXE="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\15.0\Bin\MSBuild.exe"



REM call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat -arch=amd64 -host_arch=amd64 -winsdk=10.0.16299.0"
REM call msbuild ../PowerToys.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1

call %MSBUILD_EXE% ../PowerToys.sln /p:Configuration=Release /p:Platform=x64 || exit /b 1
