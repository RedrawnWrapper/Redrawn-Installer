@echo off
if not exist %USERPROFILE%\Redrawn echo Redrawn Offline Does Not Exist On Your System. && pause & exit
if not exist %USERPROFILE%\Redrawn-Express (
        echo Redrawn Express is required in order to boot Redrawn Offline from here. 
        echo Redrawn Offline has been detected on your system so you can boot it from the dualboot.bat file.
        pause 
        exit
)
cd %USERPROFILE%\Redrawn
echo Starting Redrawn Offline...
call Redrawn.exe
exit
