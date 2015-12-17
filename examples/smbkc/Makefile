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
	rm variance
