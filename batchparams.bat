@echo off
rem http://stackoverflow.com/questions/659647/how-to-get-folder-path-from-file-path-with-cmd/659672#659672
rem http://weblogs.asp.net/jgalloway/archive/2006/11/20/top-10-dos-batch-tips-yes-dos-batch.aspx
echo %%~1     =      %~1 
echo %%~f1     =      %~f1
echo %%~d1     =      %~d1
echo %%~p1     =      %~p1
echo %%~n1     =      %~n1
echo %%~x1     =      %~x1
echo %%~s1     =      %~s1
echo %%~a1     =      %~a1
echo %%~t1     =      %~t1
echo %%~z1     =      %~z1
echo %%~$PATHATH:1     =      %~$PATHATH:1
echo %%~dp1     =      %~dp1
echo %%~nx1     =      %~nx1
echo %%~dp$PATH:1     =      %~dp$PATH:1
echo %%~ftza1     =      %~ftza1