title Redrawn
:: Redrawn Installer
:: Author: joseph the animator#2292 & IndyTheNerd#2501
:: License: MIT
:: Initialize (stop command spam, clean screen, make variables work, set to UTF-8)
:: take me to my name please.
cd %USERPROFILE%
@echo off && cls
:: check to see if both redrawn and redrawn express exists and run their start scripts
if exist %USERPROFILE%\Redrawn (
	:: check for admin rights just in case
	set "params=%*"
	cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
	title Redrawn [Booting Up]
	cd %USERPROFILE%\Redrawn
	call Redrawn.exe
	exit
)
if exist %USERPROFILE%\Redrawn-Express (
	cd Redrawn-Express
	call run.bat
)
:: check for admin rights
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:: take me to my name again please.
cd %USERPROFILE%
title Redrawn Installer
:: Predefine variables
set GIT_VERSION="2.39.0"
set NODE_VERSION="19.3.0"
set FLASH_DETECTED=n
echo Redrawn
echo Are you sure you want to install Redrawn?
echo:
echo Type y to install Redrawn, or type n to close
echo this script.
echo:
:confirmaskretry
set /p CHOICE= Choice:
echo:
if "%choice%"=="n" echo The Redrawn Installer Will Now Be Closing. && pause & exit
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
IF "%goutput%" EQU "" (
	:: checking dependencies can get inaccurate sometimes. checking by file would normally help.
	if exist git_installer.exe (
		echo Git is installed.
		goto nodecheck
	)
	echo Git could not be found.
	goto installlgit
) else ( echo Git is installed. )

:: Node.JS check
:nodecheck
echo Checking for Node.JS installation...
for /f "delims=" %%i in ('node -v 2^>nul') do set noutput=%%i
IF "%noutput%" EQU "" (
	:: checking dependencies can get inaccurate sometimes. checking by file would normally help.
	if exist node_installer.msi (
		echo Node.JS is installed
		goto flashcheck
	)
	echo Node.JS could not be found.
	goto installnode
) else ( echo Node.JS is installed. )

:: Flash check
:flashcheck
echo Checking for Flash installation...
if exist "%windir%\SysWOW64\Macromed\Flash\*pepper.exe" set FLASH_DETECTED=y
if exist "%windir%\System32\Macromed\Flash\*pepper.exe" set FLASH_DETECTED=y
if !FLASH_DETECTED!==n (
	:: checking dependencies can get inaccurate sometimes. checking by file would normally help.
	if exist install_flash.exe (
		echo Flash is installed
		goto dependencyinstallcomplete
	)
	echo Flash could not be found.
	goto installflash
) else (
	echo Flash is installed.
	echo:
)
:dependencyinstallcomplete
echo All Of The Dependencies are installed. you can now select what version of redrawn you want to install.
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
powershell -Command "Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v%GIT_VERSION%.windows.2/Git-%GIT_VERSION%-64-bit.exe -OutFile git_installer.exe"
call git_installer.exe
echo Git Has Been Installed. Checking dependencies again...
timeout 4
goto dependency_check
:installnode
powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v%NODE_VERSION%/node-v%NODE_VERSION%-x64.msi -OutFile node_installer.msi"
call node_installer.msi
echo Node.js Has Been Installed. Checking dependencies again...
timeout 4
goto dependency_check
:installflash
powershell -Command "Invoke-WebRequest https://bluepload.unstable.life/cleanflash3400277installer1.exe -OutFile install_flash.exe"
call install_flash.exe
echo Clean Flash Has Been Installed. Checking dependencies again...
timeout 4
goto dependency_check
:installchromium
powershell -Command "Invoke-WebRequest https://github.com/tangalbert919/ungoogled-chromium-binaries/releases/download/79.0.3945.130-2/ungoogled-chromium_79.0.3945.130-2.1_installer-x64.exe -OutFile chromium_installer.exe"
call chromium_installer.exe
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
call Redrawn.exe
exit
