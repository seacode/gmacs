all: pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: bbrkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("bbrkc.Rmd")' 
	pandoc -V geometry:margin=1in bbrkc.md -o bbrkc.pdf --bibliography=../references/Gmacs.bib 
	pandoc -V geometry:margin=1in app.md -o app.pdf 
	pandoc -V geometry:margin=1in bbrkc.md app.md -o bbrkc.html --bibliography=../references/Gmacs.bib

clean:
	rm bbrkc.md 
