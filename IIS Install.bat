echo off

:: Variables for holding the account of the person logging in
cd %~dp0
set /P username="Please enter the username you used to sign into Windows: "
set /P password="Please enter the password you used to sign into Windows: "

:: Install Windows Features that we need
DISM /online /enable-feature /all /featurename:IIS-WebServerManagementTools
DISM /online /enable-feature /all /featurename:IIS-ManagementScriptingTools
DISM /online /enable-feature /all /featurename:IIS-ASPNET45
DISM /online /enable-feature /all /featurename:IIS-HttpRedirect
DISM /online /enable-feature /all /featurename:IIS-BasicAuthentication
DISM /online /enable-feature /all /featurename:IIS-Metabase

:: Checks if the Mainstar folder exists.  If not, creates it
IF EXIST "C:\Mainstar" (
    ECHO found
) ELSE (
	mkdir C:\mainstar
)

:: Copies the program and settings file to the Mainstar directory
::xcopy /E /I ".\Mainstar Complete Install\MS API\mainstarpos-msapi-ffa5f0cda764\MSAPI" C:\mainstar\api\MSAPI
xcopy /E /I ".\msapiTMP" C:\mainstar\api
xcopy /E ".\settings.json" C:\mainstar\api\MSAPI
xcopy /E ".\license.json" C:\mainstar\api\MSAPI

pause

:: Creates certificate in IIS 
%systemroot%\system32\inetsrv\appcmd add site /name:MSAPI /id:10 /physicalPath:c:\mainstar\api\MSAPI /bindings:https/*:8080
selfssl.exe /N:CN=Mainstar /S:10 /P:8080 /V:365 /T /Q


:: Automate opeining firewall for the API and SQL
Netsh.exe advfirewall firewall add rule name="SQL Browser" protocol=UDP dir=in localport=1434 action=allow
Netsh.exe advfirewall firewall add rule name="SQL Server" dir=in action=allow service=MSSQL$SQLEXPRESS
Netsh.exe advfirewall firewall add rule name="MS API" protocol=TCP dir=in localport=8080 action=allow

pause

:: sets .net runtime version to 4.0, Pipeline mode to integrated, and 32 bit apps on 64 bit pc's as true.  Also sets user to computer user.  Uses variables that were set at the begining of the script.
%systemroot%\system32\inetsrv\AppCmd set AppPool /apppool.name:DefaultAppPool /managedRuntimeVersion:v4.0 /enable32BitAppOnWin64:"true" /managedPipelineMode:"Integrated" 
%systemroot%\system32\inetsrv\AppCmd set config /section:applicationPools /[name='DefaultAppPool'].processModel.identityType:SpecificUser /[name='DefaultAppPool'].processModel.userName:"%username%" /[name='DefaultAppPool'].processModel.password:"%password%"

