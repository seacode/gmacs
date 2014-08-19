@echo off
set exec=..\..\src\build\debug\gmacs.exe 
if EXIST %exec% (copy %exec% ) ELSE echo "file missing, compile source code in gmacs\src directory "
gmacs -nox %1 %2 %3 %4 %5 %6
