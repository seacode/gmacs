all: pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: bbrkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("bbrkc.Rmd")'
	pandoc -V geometry:margin=1in bbrkc.md -o bbrkc2.pdf --bibliography=../references/Gmacs.bib

clean:
	rm bbrkc.md 
