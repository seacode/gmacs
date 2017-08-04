LIB:=lib/tailcompression.cpp lib/nloglike.cpp lib/spr.cpp lib/multinomial.cpp lib/robust_multi.cpp lib/dirichlet.cpp lib/equilibrium.cpp
INC:=include/*.h include/*.hpp

ifdef ComSpec
    RM=del /F /Q
    COPY=copy
else
    RM=rm -rf
    COPY=cp
endif

all: build/debug/gmacs #build/release/gmacs

build/debug/gmacs: build/debug gmacs.tpl $(LIB) $(INC)
	@admb -g gmacs.tpl $(LIB)
	@$(COPY) gmacs build/debug/
	@$(RM) gmacs

#build/release/gmacs: build/release gmacs.tpl $(LIB) $(INC)
#	@admb -g gmacs.tpl $(LIB)
#	@$(COPY) gmacs build/release/
#	@$(RM) gmacs

build/debug:
	@echo creating debug directory
	@mkdir -p build/debug

build/release:
	@echo creating release directory
	@mkdir -p build/release

clean:
	@$(RM) build
	@$(RM) gmacs.cpp
	@$(RM) gmacs.htp
	@$(RM) gmacs.obj
	@$(RM) lib/*.obj
