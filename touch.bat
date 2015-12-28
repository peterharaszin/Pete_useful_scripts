@echo OFF
REM http://superuser.com/questions/10426/windows-equivalent-of-the-linux-command-touch/764721#764721
REM http://blogs.msdn.com/b/oldnewthing/archive/2013/07/10/10432879.aspx
REM "In Win7 this won't work if you are not in the folder containing the file. It will create a copy in the current working directory. –  Jamie Jun 27 '12 at 7:48"
set "ORIGINAL_WORKING_DIR=%CD%"
set "ORIGINAL_DRIVE_LETTER=%~d1"
REM switching to the directory of the file passed as a parameter - using the /D switch to change current drive in addition to changing current directory for a drive.
cd /d "%~dp1"
echo current wd: %CD%

@COPY /B %1+,, %1

REM changing back to the original directory
cd /d "%ORIGINAL_WORKING_DIR%"
echo current wd: %CD%
