@echo off
if not exist %USERPROFILE%\Redrawn echo Redrawn Offline Does Not Exist On Your System. && pause & exit
cd %USERPROFILE%\Redrawn
echo Starting Redrawn Offline...
call Redrawn.exe
exit