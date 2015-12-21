EXEC = gmacs
ifeq ($(SAFE),TRUE)
	DIST = ../../../src/build/debug/
else
	DIST = ../../../src/build/release/
endif
ARGS = -nox -iprint 50 

all: run

$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../../src

run: $(EXEC)
	./$(EXEC) $(ARGS)
	R CMD BATCH plot.R

plot:
	R CMD BATCH plot.R

clean:
	rm -f $(EXEC)
	rm -f admodel.*
	rm -f $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance

clobber: clean
	rm -f *.par *_in.* *.rep
