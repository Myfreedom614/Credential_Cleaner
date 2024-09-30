@echo off
cd /d %~dp0
FOR /F "tokens=1,2 delims= " %%G IN (tokens_not_contains_keywords.txt) DO cmdkey.exe /delete:%%H
echo All done
pause