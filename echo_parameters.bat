@echo OFF
REM http://stackoverflow.com/questions/19835849/batch-script-iterate-through-arguments/19837690#19837690

setlocal enabledelayedexpansion

echo first: %1
echo second: %2
echo third: %3

set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

echo Number of processed arguments: %argCount%

for /L %%i in (1,1,%argCount%) do (
	echo %%i- "!argVec[%%i]!"
)

