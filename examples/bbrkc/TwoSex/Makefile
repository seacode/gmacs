ARGS = -nox -iprint 50

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: mpd

mpd: gmacs
	$(RM) gmacs
	ln -s ../../../src/build/release/gmacs gmacs
	gmacs $(ARGS)

debug: gmacs
	$(RM) gmacs
	ln -s ../../../src/build/debug/gmacs gmacs
	gmacs $(ARGS)

plot:
	R CMD BATCH plot.R

<<<<<<< HEAD
gmacs:
	ln -s ../../../src/build/release/gmacs gmacs
=======
plot: $(EXEC)
	R CMD BATCH plot.R

clean:
	rm -f $(EXEC)
	rm -f admodel.*
	rm -f $(EXEC)  $(EXEC).[brces]* $(EXEC).*[0123456789] *.rpt *.log variance
>>>>>>> dc4dd2e124af2b1010ff9359ace2a6a12c5a3ca4

clean:
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
	@$(RM) gmacs_files_in.dat
	@$(RM) gmacs_in.ctl
	@$(RM) gmacs_in.dat
	@$(RM) gradient.*
	@$(RM) mcout.rep
	@$(RM) plot.Rout
	@$(RM) Rplots.pdf
	@$(RM) sims
	@$(RM) variance
