if NOT EXIST build mkdir build
if NOT EXIST build\debug mkdir build\debug
if NOT EXIST build\release mkdir build\release
copy lib\*.cpp
call admb -g gmacs.tpl tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp
copy gmacs.exe build\debug
call admb -f gmacs.tpl tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp
copy gmacs.exe build\release
:: Cleanup src directory (these files live in lib directory)
del tailcompression.cpp nloglike.cpp spr.cpp multinomial.cpp robust_multi.cpp

