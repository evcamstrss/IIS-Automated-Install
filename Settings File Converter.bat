
cd C:\mainstar\api\MSAPI
::echo off

::setlocal enabledelayedexpansion
set INTEXTFILE=settings.json
set OUTTEXTFILE=settingsCHANGED.json






set /P varuser="Please enter the account name: "

set SEARCHTEXT=b7qxaccountb7qx
set REPLACETEXT=%varuser%
set OUTPUTLINE=

for /f "tokens=1,* delims=*" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
)
del %INTEXTFILE%
rename %OUTTEXTFILE% %INTEXTFILE%






set /P varpassword="Please enter the accout password: "

set SEARCHTEXT=b7qxpasswordb7qx
set REPLACETEXT=%varpassword%
set OUTPUTLINE=

for /f "tokens=1,* delims=*" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
)
del %INTEXTFILE%
rename %OUTTEXTFILE% %INTEXTFILE%






set /P vardatabase="Please enter the name of the SQL instance [probably SQLEXPRESS2016]: "

set SEARCHTEXT=b7qxdatabasenameb7qx
set REPLACETEXT=%vardatabase%
set OUTPUTLINE=

for /f "tokens=1,* delims=*" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
)
del %INTEXTFILE%
rename %OUTTEXTFILE% %INTEXTFILE%






set /P varpcname="Please enter the PC name: "

set SEARCHTEXT=b7qxinstanceb7qx
set REPLACETEXT=%varpcname%
set OUTPUTLINE=

for /f "tokens=1,* delims=*" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!

echo !modified! >> %OUTTEXTFILE%
)
del %INTEXTFILE%
rename %OUTTEXTFILE% %INTEXTFILE%






more settings.json
pause