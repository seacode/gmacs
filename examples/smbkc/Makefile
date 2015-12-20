ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: mpd

mpd: gmacs
	rm gmacs
	ln -s ../../src/build/release/gmacs gmacs
	gmacs -nox

debug: gmacs
	rm gmacs
	ln -s ../../src/build/debug/gmacs gmacs
	gmacs -nox

plot:
	R CMD BATCH plot.R

gmacs:
	ln -s ../../src/build/release/gmacs gmacs

clean:
	sudo rm gmacs
	@$(RM) admodel.cov
	@$(RM) admodel.dep
	@$(RM) admodel.hes
	@$(RM) checkfile.rep
	@$(RM) fmin.log
	@$(RM) gmacs.b0*
	@$(RM) gmacs.bar
	@$(RM) gmacs.cor
	@$(RM) gmacs.eva
	@$(RM) gmacs.log
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
	@$(RM) variance
