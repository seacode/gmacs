LIB:=lib/tailcompression.cpp lib/nloglike.cpp lib/spr.cpp lib/multinomial.cpp lib/robust_multi.cpp lib/dirichlet.cpp lib/equilibrium.cpp
INC:=include/*.h include/*.hpp
MOD:=gmacs

ifdef ComSpec
    RM=del /F /Q
    COPY=copy
		EXE=$(MOD).exe
    SEP:=\
else
    RM=rm -rf
    SEP:=/
    COPY=cp
		EXE=$(MOD)
endif

all: build/debug/gmacs  build/release/gmacs

build/debug/gmacs: build/debug gmacs.tpl $(LIB) $(INC)
	@admb -g gmacs.tpl $(LIB)
	@$(COPY) $(EXE) build$(SEP)debug$(SEP)
	@$(RM) $(EXE)

build/release/gmacs: build/release gmacs.tpl $(LIB) $(INC)
	@admb -g gmacs.tpl $(LIB)
	@$(COPY) $(EXE) build$(SEP)release$(SEP)
	@$(RM) $(EXE) 

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
