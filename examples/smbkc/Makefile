all: mpd

mpd: gmacs
	sudo rm gmacs
	sudo ln -s ../../src/build/release/gmacs gmacs
	gmacs

debug: gmacs
	sudo rm gmacs
	sudo ln -s ../../src/build/debug/gmacs gmacs
	gmacs

plot:
	R CMD BATCH plot.R

gmacs:
	sudo ln -s ../../src/build/release/gmacs gmacs

clean:
	sudo rm gmacs
	rm admodel.cov
	rm admodel.dep
	rm admodel.hes
	rm checkfile.rep
	rm fmin.log
	rm gmacs.b0*
	rm gmacs.bar
	rm gmacs.cor
	rm gmacs.eva
	rm gmacs.log
	rm gmacs.p0*
	rm gmacs.par
	rm gmacs.r0*
	rm gmacs.rep
	rm gmacs.std
	rm gmacs_files_in.dat
	rm gmacs_in.ctl
	rm gmacs_in.dat
	rm gradient.*
	rm mcout.rep
	rm plot.Rout
	rm Rplots.pdf
	rm variance
