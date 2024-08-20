@echo off
cls
setlocal enabledelayedexpansion

:: Enable ANSI Escape Sequences
reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f > nul 2>&1

:: Set up logging
set "logfile=%temp%\framework_installer_log.txt"
echo Framework Installer Log > %logfile%
echo Timestamp: %date% %time% >> %logfile%

:: Check if dotnet is installed
dotnet --list-runtimes | find "Microsoft.NETCore.App" >nul 2>&1
if %errorlevel% neq 0 (
    echo Dotnet is not installed or not available. Please install it from: https://download.visualstudio.microsoft.com/download/pr/76e5dbb2-6ae3-4629-9a84-527f8feb709c/09002599b32d5d01dc3aa5dcdffcc984/windowsdesktop-runtime-8.0.6-win-x64.exe >> %logfile%
    exit /b 1
)

:: Install DirectX
echo Installing DirectX... >> %logfile%
powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe' -OutFile '%temp%\dxwebsetup.exe'" >> %logfile% 2>&1

:: Create a directory for extraction
mkdir "%temp%\dxsetup" >> %logfile% 2>&1

:: Extract the contents
start /wait %temp%\dxwebsetup.exe /Q /T:"%temp%\dxsetup" >> %logfile% 2>&1

:: Run the actual setup
start /wait "%temp%\dxsetup\DXSETUP.exe" /silent >> %logfile% 2>&1

:: Clean up
rmdir /S /Q "%temp%\dxsetup" >> %logfile% 2>&1
del /F /Q %temp%\dxwebsetup.exe >> %logfile% 2>&1

echo DirectX installation completed. >> %logfile%

:: Install .NET Frameworks
echo Installing .NET Frameworks... >> %logfile%

:: Install .NET 5.0
dotnet --list-runtimes | find "Microsoft.NETCore.App 5.0." >nul
if %errorlevel% neq 0 (
    echo Installing .NET 5.0... >> %logfile%
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/3aa4e942-42cd-4bf5-afe7-fc23bd9c69c5/64da54c8864e473c19a7d3de15790418/windowsdesktop-runtime-5.0.17-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-5.0.17-win-x64.exe'" >> %logfile% 2>&1
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/b6fe5f2a-95f4-46f1-9824-f5994f10bc69/db5ec9b47ec877b5276f83a185fdb6a0/windowsdesktop-runtime-5.0.17-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-5.0.17-win-x86.exe'" >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-5.0.17-win-x86.exe /quiet /norestart >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-5.0.17-win-x64.exe /quiet /norestart >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-5.0.17-win-x86.exe >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-5.0.17-win-x64.exe >> %logfile% 2>&1
)

:: Install .NET 6.0
dotnet --list-runtimes | find "Microsoft.NETCore.App 6.0." >nul
if %errorlevel% neq 0 (
    echo Installing .NET 6.0... >> %logfile%
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/a1da19dc-d781-4981-84e9-ffa0c05e00e9/46f3cd2015c27a0e93d7c102a711577e/windowsdesktop-runtime-6.0.31-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-6.0.31-win-x64.exe'" >> %logfile% 2>&1
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/b5fbd3de-7a12-43ba-b460-2f938fd802c3/627f6335ef3ba17bd3ef901c790d7575/windowsdesktop-runtime-6.0.31-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-6.0.31-win-x86.exe'" >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-6.0.31-win-x86.exe /quiet /norestart >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-6.0.31-win-x64.exe /quiet /norestart >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-6.0.31-win-x86.exe >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-6.0.31-win-x64.exe >> %logfile% 2>&1
)

:: Install .NET 7.0
dotnet --list-runtimes | find "Microsoft.NETCore.App 7.0." >nul
if %errorlevel% neq 0 (
    echo Installing .NET 7.0... >> %logfile%
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/08bbfe8f-812d-479f-803b-23ea0bffce47/c320e4b037f3e92ab7ea92c3d7ea3ca1/windowsdesktop-runtime-7.0.20-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-7.0.20-win-x64.exe'" >> %logfile% 2>&1
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/ff4b13ba-07aa-4aa7-b5ae-9111c363c802/5fdedee9a9fae645bfdda3a8930c923d/windowsdesktop-runtime-7.0.16-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-7.0.16-win-x86.exe'" >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-7.0.16-win-x86.exe /quiet /norestart >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-7.0.20-win-x64.exe /quiet /norestart >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-7.0.16-win-x86.exe >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-7.0.20-win-x64.exe >> %logfile% 2>&1
)

:: Install .NET 8.0
dotnet --list-runtimes | find "Microsoft.NETCore.App 8.0." >nul
if %errorlevel% neq 0 (
    echo Installing .NET 8.0... >> %logfile%
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/9b77b480-7e32-4321-b417-a41e0f8ea952/3922bbf5538277b1d41e9b49ee443673/windowsdesktop-runtime-8.0.2-win-x86.exe' -OutFile '%temp%\windowsdesktop-runtime-8.0.2-win-x86.exe'" >> %logfile% 2>&1
    powershell -Command "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/9b77b480-7e32-4321-b417-a41e0f8ea952/3922bbf5538277b1d41e9b49ee443673/windowsdesktop-runtime-8.0.2-win-x64.exe' -OutFile '%temp%\windowsdesktop-runtime-8.0.2-win-x64.exe'" >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-8.0.2-win-x86.exe /quiet /norestart >> %logfile% 2>&1
    start /wait %temp%\windowsdesktop-runtime-8.0.2-win-x64.exe /quiet /norestart >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-8.0.2-win-x86.exe >> %logfile% 2>&1
    del /F /Q %temp%\windowsdesktop-runtime-8.0.2-win-x64.exe >> %logfile% 2>&1
)

:: Install Visual C++ Redistributable
echo Installing Visual C++ Redistributable... >> %logfile%
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s /f "Microsoft Visual C++" > nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Invoke-WebRequest 'https://kutt.it/vcpp' -OutFile '%temp%\vc_redist.x64.exe'" >> %logfile% 2>&1
    start /wait %temp%\vc_redist.x64.exe /aiA /gm2 /norestart >> %logfile% 2>&1
    del /F /Q %temp%\vc_redist.x64.exe >> %logfile% 2>&1
)


echo Installation completed. >> %logfile%
echo Please check the log file for details: %logfile%