@echo OFF
rem http://prohardver.hu/tema/total_commander/hsz_1952-1955.html
rem Toolbar:
rem http://prohardver.hu/dl/upc/2013-10/52551_total_commander_button_bar_srt-atnevezo_batch-prog.png
rem Renaming SRT subtitle files this way: the batch script takes the (video) file's name (given as a parameter),
rem looks for the FIRST srt file in the directory and renames it to match the video file's name (without the extension)
rem (and appends the srt extension). It can be used as a Total Commander plugin
echo === Renaming SRT subtitle files === 
echo.

if [%1]==[] (
  echo The parameter is missing!
  goto :exit
)

set first_argument=%1
rem Trick to remove double quotes from the variable:
rem http://stackoverflow.com/questions/1964192/removing-double-quotes-from-variables-in-batch-file-creates-problems-with-cmd-en/5181182#5181182
set first_argument=%first_argument:"=%
set first_srt_filename=""
set first_srt_filename_without_extension=""

for %%F in (*.srt) do (
  set first_srt_filename=%%F
  set first_srt_filename_without_extension=%%~nF
  goto :rename_srt
)

if %first_srt_filename%=="" (
  echo This directory contains no srt files.
  goto :exit
)

:rename_srt
echo Renaming "%first_srt_filename%" file to "%first_argument%.srt"
ren "%first_srt_filename%" "%first_argument%.srt"
if not %errorlevel%==0 (
  echo An error occurred while trying to rename the file!
  goto :exit
)
echo Done.

echo.
echo The list of the srt file in the current directory is the following:
dir *.srt /B

:exit
echo.
echo === Done, bye! === 
rem 
rem pause
