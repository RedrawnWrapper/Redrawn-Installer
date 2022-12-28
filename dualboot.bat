@echo off
if exist %USERPROFILE%\Redrawn-Express goto startredrawnexpress
if exist %USERPROFILE%\Redrawn goto startredrawnoffline
echo Redrawn Offline and Redrawn Express was not detected on your system && pause && exit
:startredrawnoffline
cd %USERPROFILE%\Redrawn
echo Starting Redrawn Offline...
call Redrawn.exe
exit
:startredrawnexpress
cd %USERPROFILE%\Redrawn-Express
echo Starting Redrawn Express...
start %USERPROFILE%\AppData\Local\Chromium\Application\chrome.exe --app=http://localhost/
call run.bat
