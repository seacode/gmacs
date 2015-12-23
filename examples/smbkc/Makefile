EXEC = gmacs
ARGS = -nox -iprint 50 

ifeq ($(SAFE),TRUE)
	DIST = ../../src/build/debug/
else
	DIST = ../../src/build/release/
endif

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: run

$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

run: $(EXEC)
	./$(EXEC) $(ARGS)
	R CMD BATCH plot.R

sim: $(EXEC)
	./$(EXEC) -ainp gmacs.par -sim 123

plot:
	R CMD BATCH plot.R

clean:
	@$(RM) -f $(EXEC)
	@$(RM) -f admodel.*
	@$(RM) -f $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance

clobber: clean
	@$(RM) -f *.par *_in.* *.rep
