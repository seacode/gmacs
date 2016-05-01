all: pdf

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: smbkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("smbkc.Rmd")' 
	pandoc -V geometry:margin=1in smbkc.md -o smbkc.pdf --bibliography=../references/Gmacs.bib
	pandoc -V geometry:margin=1in app.md -o app.pdf 
	pandoc -V geometry:margin=1in smbkc.md app.md -o smbkc.html --bibliography=../references/Gmacs.bib

clean:
	rm smbkc.md 
