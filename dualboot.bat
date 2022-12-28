@echo off
if exist %USERPROFILE%\Redrawn (
	if exist %USERPROFILE%\Redrawn-Express (
		echo The Installer has noticed that both Redrawn Offline And Redrawn Express already exists. witch one do you want to start up?
		echo 1 Redrawn Offline
		echo 2 Redrawn Express
		set /p CHOICE= Choice:
		if "%choice%"=="1" goto startredrawnoffline
		if "%choice%"=="2" goto startredrawnexpress
	) else goto startredrawnoffline
)
if exist %USERPROFILE%\Redrawn-Express goto startredrawnexpress
:startredrawnoffline
cd %USERPROFILE%\Redrawn
echo Starting Redrawn Offline...
call Redrawn.exe
exit
:startredrawnexpress
cd %USERPROFILE%\Redrawn-Express
echo Starting Redrawn Express...
start run.bat
timeout 120
start %USERPROFILE%\AppData\Local\Chromium\Application\chrome.exe --app=http://localhost/
npm start