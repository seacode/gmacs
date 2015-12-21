<<<<<<< HEAD
ARGS = -nox -iprint 50
=======
EXEC = gmacs
ifeq ($(SAFE),TRUE)
	DIST = ../../src/build/debug/
else
	DIST = ../../src/build/release/
endif
ARGS = -nox -iprint 50 
>>>>>>> dc4dd2e124af2b1010ff9359ace2a6a12c5a3ca4

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: mpd
$(EXEC): $(DIST)$(EXEC).tpl
	ln -sf $(DIST)$(EXEC) $@

<<<<<<< HEAD
mpd: gmacs
	$(RM) gmacs
	ln -s ../../src/build/release/gmacs gmacs
	gmacs $(ARGS)

debug: gmacs
	$(RM) gmacs
	ln -s ../../src/build/debug/gmacs gmacs
	gmacs $(ARGS)
=======
$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src


mpd: $(EXEC)
	./$(EXEC) $(ARGS)

debug: $(EXEC)
	./$(EXEC) $(ARGS)
>>>>>>> dc4dd2e124af2b1010ff9359ace2a6a12c5a3ca4

plot:
	R CMD BATCH plot.R

clean:
<<<<<<< HEAD
	@$(RM) gmacs
	@$(RM) admodel.cov
	@$(RM) admodel.dep
	@$(RM) admodel.hes
	@$(RM) checkfile.rep
	@$(RM) fmin.log
	@$(RM) gmacs.b0*
	@$(RM) gmacs.bar
	@$(RM) gmacs.cor
	@$(RM) gmacs.ecm
	@$(RM) gmacs.eva
	@$(RM) gmacs.hst
	@$(RM) gmacs.log
	@$(RM) gmacs.mc2
	@$(RM) gmacs.mcm
	@$(RM) gmacs.p0*
	@$(RM) gmacs.par
	@$(RM) gmacs.r0*
	@$(RM) gmacs.rep
	@$(RM) gmacs.std
=======
	@$(RM) $(EXEC)
	@$(RM) $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance gradient.*
	@$(RM) admodel.*
	@$(RM) checkfile.rep
>>>>>>> dc4dd2e124af2b1010ff9359ace2a6a12c5a3ca4
	@$(RM) gmacs_files_in.dat
	@$(RM) gmacs_in.ctl
	@$(RM) gmacs_in.dat
	@$(RM) mcout.rep
	@$(RM) plot.Rout
	@$(RM) Rplots.pdf
<<<<<<< HEAD
	@$(RM) sims
	@$(RM) variance
=======
>>>>>>> dc4dd2e124af2b1010ff9359ace2a6a12c5a3ca4
