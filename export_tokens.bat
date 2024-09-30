@echo off
cd /d %~dp0
cmdkey.exe /list > "List.txt"
findstr.exe Target "List.txt" > "tokensonly.txt"
del "List.txt" /s /f /q
echo All done
pause