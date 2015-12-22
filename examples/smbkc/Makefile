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

all: mpd

$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

mpd: $(EXEC)
	./$(EXEC) $(ARGS)

debug: $(EXEC)
	./$(EXEC) $(ARGS)

sim: $(EXEC)
	./$(EXEC) -ainp gmacs.par -sim 123

plot:
	R CMD BATCH plot.R

clean:
	@$(RM) $(EXEC)
	@$(RM) $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance gradient.*
	@$(RM) admodel.*
	@$(RM) checkfile.rep
	@$(RM) gmacs_files_in.dat
	@$(RM) gmacs_in.ctl
	@$(RM) gmacs_in.dat
	@$(RM) mcout.rep
	@$(RM) plot.Rout
	@$(RM) Rplots.pdf
