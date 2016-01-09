@echo off
rem http://superuser.com/questions/149951/does-in-batch-file-mean-all-command-line-arguments
rem http://stackoverflow.com/questions/5735146/windows-7-batch-files-how-to-check-if-parameter-has-been-passed-to-batch-file/16819109#16819109

if "%~1"=="" (
	echo No parameters have been provided.
) else (
	echo Parameters:
	echo %*
)

pause
