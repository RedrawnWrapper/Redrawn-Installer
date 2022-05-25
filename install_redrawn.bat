:: Redrawn Installer
:: Author: joseph the animator#2292
:: License: MIT
title Redrawn Installer [Initializing...]

::::::::::::::::::::
:: Initialization ::
::::::::::::::::::::

:: Stop commands from spamming stuff, cleans up the screen
@echo off && cls

:: Lets variables work or something idk im not a nerd
SETLOCAL ENABLEDELAYEDEXPANSION

:: Make sure we're starting in the correct folder, and that it worked (otherwise things would go horribly wrong)
pushd "%~dp0"

:: Check *again* because it seems like sometimes it doesn't go into dp0 the first time???
pushd "%~dp0"

:::::::::::::::::::::::
:: Redrawn Installer ::
:::::::::::::::::::::::

title Redrawn Installer
:cls
cls

echo Redrawn Installer
echo Project led by MiiArtisan. 
echo Installer is created by the Joseph Animate 2022. 
echo:
echo Enter 1 to install Redrawn
echo Enter 0 to close the installer
:wrapperidle
echo:

:::::::::::::
:: Choices ::
:::::::::::::

set /p CHOICE=Choice:
if "!choice!"=="0" goto exit
if "!choice!"=="1" goto download
echo Time to choose. && goto wrapperidle

:download
cls
echo Sorry, 
echo but due to so many bugs being inside of redrawn, 
echo you can't install the software right now. 
echo Would you like to get Vyond Legacy Offline Instead?
echo:
echo Enter y for yes
echo Enter n for no
:choices
echo:

:::::::::::::
:: Choices ::
:::::::::::::

set /p CHOICE=Response:
if "!choice!"=="n" goto dontinstallvyond
if "!choice!"=="y" goto downloadVyond
echo Time to choose. && goto choices

:exit
echo the Redrawn installer has been closed.
pause & exit

:dontinstallvyond
echo You desided to not install Vyond Legacy Offline. The Instaler shall now close.
pause & exit

:downloadVyond
cls
pushd "..\..\"
echo Cloning repository from GitHub...
call Redrawn-Installer-main\Redrawn-Installer-main\PortableGit\bin\git.exe clone https://github.com/josephanimate2021/Vyond-Legacy-Offline.git
echo Vyond Legacy Offline Has Been Installed
pause
goto cls
