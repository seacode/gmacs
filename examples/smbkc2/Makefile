MODS:=model_1 model_2
DEL:=admodel.cov admodel.dep admodel.hes checkfile.rep fmin.log gmacs.b0* gmacs.bar gmacs.cor gmacs.eva gmacs.log gmacs.p0* gmacs.par gmacs.r0* gmacs.rep gmacs.std gmacs_files_in.dat gmacs_in.ctl gmacs_in.dat gradient.* mcout.rep variance

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: mpd

mpd:
	for number in $(MODS) ; do \
		cd $$number ; \
		ln -s ../../../src/build/release/gmacs gmacs ; \
		gmacs ; \
		$(RM) gmacs ; \
		cd .. ; \
	done

debug:
	for number in $(MODS) ; do \
		cd $$number ; \
		ln -s ../../../src/build/debug/gmacs gmacs ; \
		gmacs ; \
		$(RM) gmacs ; \
		cd .. ; \
	done

plot:
	R CMD BATCH plot.R

clean:
	for number in $(MODS) ; do \
		cd $$number ; \
		$(RM) $(DEL) ; \
		cd .. ; \
	done
