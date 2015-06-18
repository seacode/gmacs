@echo off
set exec=..\..\..\src\build\release\gmacs.exe 
:: if EXIST %exec% (mklink /D  %exec% gmacs.exe ) ELSE echo "file missing, compile source code in gmacs\src directory "
if EXIST %exec% (copy %exec% gmacs.exe ) ELSE echo "file missing, compile source code in gmacs\src directory "
gmacs -nox %1 %2 %3 %4 %5 %6
