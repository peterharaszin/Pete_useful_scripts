@echo off
REM SETLOCAL ENABLEEXTENSIONS
REM setlocal EnableDelayedExpansion
rem http://stackoverflow.com/questions/5898763/how-do-i-get-the-ip-address-into-a-batch-file-variable

echo ===========================================================

FOR /F "tokens=4 delims= " %%i in ('route print ^| find " 0.0.0.0"') do set localIp=%%i
echo Your internal (local) IP Address is: %localIp%

echo ===========================================================
echo ====================(other methods)========================
echo ===========================================================

wmic NICCONFIG WHERE IPEnabled=true GET Caption,IPAddress /format:csv

echo ================

for /f "skip=1 delims={}, " %%A in ('wmic nicconfig get ipaddress') do (
    for /f "tokens=1" %%B in ("%%~A") do (
        set "IP=%%~B"
    )
)
echo %IP%
echo ================

REM set IP_Addresses_CSV_format='wmic NICCONFIG WHERE IPEnabled^="true" GET Caption^,IPAddress /format:csv'

rem The equation sign and the comma also has to be escaped!!
rem skip=2 --> skip 1st and 2nd lines
for /f "skip=2 tokens=1-3 delims=," %%f IN ('wmic NICCONFIG WHERE IPEnabled^="true" GET Caption^,IPAddress /format:csv') do (
    echo Node: %%f
    echo Adapter: %%g
    echo IP addresses: %%h
    REM for /f "skip=1 tokens=1-3 delims=;" %%i IN ("%%h") do (
        REM echo i: %%i
        REM echo j: %%j
    REM )
)

echo ================

for /f "delims=[] tokens=2" %%a in ('ping %computername% -4 -n 1 ^| findstr "["') do (
    set thisipv4=%%a
)
for /f "delims=[] tokens=2" %%b in ('ping %computername% -6 -n 1 ^| findstr "["') do (
    set thisipv6=%%b
)
echo IPv4 address: %thisipv4%
echo IPv6 address: %thisipv6%

echo ================

ipconfig | findstr /R /C:"IP.* "

echo ===========================================================

for /f "tokens=*" %%a in ('getwebsitecontent.bat http://peterharaszin.hu/ipcimem/') do set externalipaddress=%%a
echo External IP address: %externalipaddress%

echo ===========================================================

pause

REM setlocal enabledelayedexpansion
REM ::just a sample adapter here:
REM set "adapter=Ethernet adapter VirtualBox Host-Only Network"
REM set adapterfound=false
REM echo Network Connection Test
REM for /f "usebackq tokens=1-2 delims=:" %%f in (`ipconfig /all`) do (
    REM set "item=%%f"
    REM if /i "!item!"=="!adapter!" (
        REM set adapterfound=true
    REM ) else if not "!item!"=="!item:IP Address=!" if "!adapterfound!"=="true" (
        REM echo Your IP Address is: %%g
        REM set adapterfound=false
    REM )
REM )