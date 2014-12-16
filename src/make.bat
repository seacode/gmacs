if NOT EXIST build mkdir build
if NOT EXIST build\debug mkdir build\debug
if NOT EXIST build\release mkdir build\release
copy lib\*.cpp
call admb -g gmacs.tpl tailcompression.cpp multinomial.cpp nloglike.cpp spr.cpp
copy gmacs.exe build\debug
call admb -f gmacs.tpl tailcompression.cpp multinomial.cpp nloglike.cpp spr.cpp
copy gmacs.exe build\release
del tailcompression.cpp multinomial.cpp nloglike.cpp spr.cpp

