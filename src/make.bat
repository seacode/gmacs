if NOT EXIST build mkdir build
if NOT EXIST build\debug mkdir build\debug
if NOT EXIST build\release mkdir build\release
call admb -g gmacs.tpl lib\tailcompression.cpp lib\multinomial.cpp lib\nloglike.cpp lib\spr.cpp
copy gmacs.exe build\debug
call admb -f gmacs.tpl lib\tailcompression.cpp lib\multinomial.cpp lib\nloglike.cpp lib\spr.cpp
copy gmacs.exe build\release
