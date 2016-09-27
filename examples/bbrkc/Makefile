EXEC = gmacs
ifeq ($(OPT),TRUE)
	DIST = ../../src/build/release/
else
	DIST = ../../src/build/debug/
endif
ARGS = -nox -iprint 50 

all: run

$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

run: $(EXEC)
	./$(EXEC) $(ARGS)

clean:
	rm -f $(EXEC)
	rm -f admodel.*
	rm -f $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance

clobber: clean
	rm -f *.par *_in.* *.rep
