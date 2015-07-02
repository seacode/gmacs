mkdir build/
mkdir build/debug/
mkdir build/release/
admb -g gmacs.tpl lib/tailcompression.cpp lib/nloglike.cpp lib/spr.cpp lib/multinomial.cpp lib/robust_multi.cpp lib/equilibrium.cpp lib/dirichlet.cpp
cp gmacs build/debug/
admb -f gmacs.tpl lib/tailcompression.cpp lib/nloglike.cpp lib/spr.cpp lib/multinomial.cpp lib/robust_multi.cpp lib/equilibrium.cpp lib/dirichlet.cpp
cp gmacs build/release/
rm gmacs gmacs.obj gmacs.cpp gmacs.htp
rm lib/*.obj
sudo rm /usr/bin/gmacs
sudo ln -s ~/proj/gmacs/src/build/release/gmacs /usr/bin/gmacs
