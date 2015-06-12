all: pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file # vanilla, but with --environ

pdf: BBRKC_Comparisons.Rmd
	R ${R_OPTS} -e 'library(knitr);knit("BBRKC_Comparisons.Rmd")'
	pandoc BBRKC_Comparisons.md -o BBRKC_Comparisons.pdf --bibliography=../../../docs/references/Gmacs.bib


clean:
	rm BBRKC_Comparisons.md 
