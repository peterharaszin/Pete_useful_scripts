@ECHO OFF

REM @ECHO OFF & CLS & ECHO.
REM http://stackoverflow.com/questions/7044985/how-can-i-auto-elevate-my-batch-file-so-that-it-requests-from-uac-admin-rights/12264592#12264592
REM show an error message and exit if there are no admin privileges (instead of auto-elevating)
NET FILE 1>NUL 2>NUL

REM IF ERRORLEVEL 1 (
if NOT %ERRORLEVEL%==0 (
  ECHO You must right-click and select "RUN AS ADMINISTRATOR"  to run this batch.
  ECHO.
  PAUSE
  goto exit_label
  REM EXIT /D
)
REM ... proceed here with admin rights ...

:got_admin_rights
echo Cool, you've got admin rights! :)
pause

:exit_label
echo Exiting...