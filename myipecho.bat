@echo off
rem http://stackoverflow.com/questions/5898763/how-do-i-get-the-ip-address-into-a-batch-file-variable
for /f "delims=[] tokens=2" %%a in ('ping %computername% -4 -n 1 ^| findstr "["') do (set thisipv4=%%a)
for /f "delims=[] tokens=2" %%b in ('ping %computername% -6 -n 1 ^| findstr "["') do (set thisipv6=%%b)
echo IPv4 address: %thisipv4%
echo IPv6 address: %thisipv6%

for /f "tokens=*" %%a in ('getwebsitecontent.bat http://peterharaszin.hu/ipcimem/') do set externalipaddress=%%a
echo External IP address: %externalipaddress%

pause