all: pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file # vanilla, but with --environ

pdf: bbrkc.Rmd
	R ${R_OPTS} -e 'library(knitr);knit("bbrkc.Rmd")'
	pandoc bbrkc.md -o bbrkc2.pdf --bibliography=../references/Gmacs.bib

clean:
	rm bbrkc.md 
