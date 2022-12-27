title Redrawn Installer
:: Redrawn Installer
:: Author: joseph the animator#2292 & IndyTheNerd#2501
:: License: MIT

:: Initialize (stop command spam, clean screen, make variables work, set to UTF-8)
@echo off && cls
:: take me to my name please.
cd %USERPROFILE%

:: Predefine variables
set GIT_VERSION="2.39.0"
set NODE_VERSION="19.3.0"
set CPU_ARCHITECTURE=what
if /i "%processor_architecture%"=="x86" set CPU_ARCHITECTURE=32
if /i "%processor_architecture%"=="AMD64" set CPU_ARCHITECTURE=64
if /i "%PROCESSOR_ARCHITEW6432%"=="AMD64" set CPU_ARCHITECTURE=64
if %CPU_ARCHITECTURE%==what ( cls && echo Error: your cpu arch has not been detected correctly and is required to install redrawn. please restart the installation and try again later && pause & exit )

echo Redrawn
echo Are you sure you want to install Redrawn?
echo:
echo Type y to install Redrawn, or type n to close
echo this script.
echo:
:confirmaskretry
set /p CHOICE= Choice:
echo:
if "%choice%"=="n" exit
if "%choice%"=="y" goto dependency_check
echo Time to choose. && goto confirmaskretry
cls

:: Ask for the version
:versionask
cls
echo Redrawn
echo Are you sure you want to install Redrawn?
echo:
echo Enter 1 to install the express edition of redrawn. (stable)
echo Enter 2 to install the offline version of redrawn. (beta)
echo Enter 0 to cancel the installation.
echo:
:versionaskretry
set /p CHOICE= Choice:
echo:
if "%choice%"=="0" exit
if "%choice%"=="1" goto chromiumcheck
if "%choice%"=="2" goto installofflineversion
echo Time to choose. && goto versionaskretry
cls

::::::::::::::::::::::
:: Dependency Check ::
::::::::::::::::::::::

:dependency_check
title Redrawn Installer [Checking for dependencies...]
echo Checking for dependencies...
echo:

:: Git check
echo Checking for Git installation...
for /f "delims=" %%i in ('git --version 2^>nul') do set goutput=%%i
IF "!goutput!" EQU "" (
	echo Git could not be found.
	goto installlgit
) else ( echo Git is installed. )

:: Node.JS check
echo Checking for Node.JS installation...
for /f "delims=" %%i in ('node -v 2^>nul') do set noutput=%%i
IF "!noutput!" EQU "" (
	echo Node.JS could not be found.
	echo:
	set NODE_NEEDED=y
) else ( echo Node.JS is installed. )

:: Flash check
echo Checking for Flash installation...
if exist "!windir!\SysWOW64\Macromed\Flash\*pepper.exe" set FLASH_DETECTED=y
if exist "!windir!\System32\Macromed\Flash\*pepper.exe" set FLASH_DETECTED=y
if !FLASH_DETECTED!==n (
	echo Flash could not be found.
	echo:
	set DEPENDENCIES_NEEDED=y
) else (
	echo Flash is installed.
	echo:
)
echo All Of Your Dependencies are installed. you can now select what version of redrawn you want to install.
timeout 7
goto versionask

:chromiumcheck
if not exist %USERPROFILE%\AppData\Local\Chromium\Application (
	echo Chromium Is Not Installed && timeout 4 && goto installchromium
) else ( echo Chromium Is Installed && timeout 4 && goto installexpress )

::::::::::::::::::::::::
:: Dependency Install ::
::::::::::::::::::::::::

:: Install Git
:installlgit
call powershell.exe --Invoke-WebRequest -Uri “https://github.com/git-for-windows/git/releases/download/v%GIT_VERSION%.windows.2/Git-%GIT_VERSION%-%CPU_ARCHITECTURE%-bit.exe”
ren Git-%GIT_VERSION%-%CPU_ARCHITECTURE%-bit.exe git_installer.exe
start git_installer.exe
echo Git Has Been Installed. Checking dependencies again...
del git_installer.exr
timeout 4
goto dependency_check
:installnode
call powershell.exe --Invoke-WebRequest -Uri “https://nodejs.org/dist/v%NODE_VERSION%/node-v%NODE_VERSION%-x%CPU_ARCHITECTURE%.msi”
ren node-v%NODE_VERSION%-x%CPU_ARCHITECTURE%.msi node_installer.msi
start node_installer.msi
echo Node.js Has Been Installed. Checking dependencies again...
del node_installer.msi
timeout 4
goto dependency_check
:installflash
call powershell.exe --Invoke-WebRequest -Uri “https://bluepload.unstable.life/cleanflash3400277installer1.exe”
start cleanflash3400277installer1.exe
echo Clean Flash Has Been Installed. Checking dependencies again...
del cleanflash3400277installer1.exe
timeout 4
goto dependency_check
:installchromium
call powershell.exe --Invoke-WebRequest -Uri “https://github.com/tangalbert919/ungoogled-chromium-binaries/releases/download/79.0.3945.130-2/ungoogled-chromium_79.0.3945.130-2.1_installer-x%CPU_ARCHITECTURE%.exe”
ren ungoogled-chromium_79.0.3945.130-2.1_installer-x%CPU_ARCHITECTURE%.exe chromium_installer.exe
start chromium_installer.exe
echo Chromium Has Been Installed. Checking dependencies again...
timeout 4
for %%i in (firefox,palemoon,iexplore,microsoftedge,chrome,chrome64,opera,brave) do (
	taskkill /f /im %%i.exe /t >nul
	wmic process where name="%%i.exe" call terminate >nul
)
goto dependency_check

:::::::::::::::::::::::::
:: Downloading Redrawn ::
:::::::::::::::::::::::::

:installexpress
git clone https://github.com/RedrawnWrapper/Redrawn-Express.git
echo Redrawn Express has been sucessfully cloned. running the start script for redrawn...
timeout 4
echo Note: Redrawn might not start after all of the dependencies install. 
echo a 2 minute timer has been put in place to ensure that redrawn starts after all of the npm dependencies get installed.
echo All Quedtions and anwsers about the redrawn install script file will be anwsered on the redrawn discord server.
timeout 60
cd Redrawn-Express
start run.bat
timeout 120
start %USERPROFILE%\AppData\Local\Chromium\Application\chrome.exe --app=http://localhost/
npm start
:installofflineversion
git clone https://github.com/RedrawnWrapper/Redrawn.git
echo Redrawn Offline has been sucessfully cloned. running the start script for redrawn...
timeout 4
cd Redrawn
start start_redrawn.bat
exit
