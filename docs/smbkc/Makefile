ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: pdf clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: smbkc.R app.Rmd
	cp smbkc.R smbkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("smbkc.Rmd"); knit("app.Rmd")'
	pandoc -V geometry:margin=1in smbkc.md -o smbkc.pdf --bibliography=../references/Gmacs.bib
	pandoc -V geometry:margin=1in app.md -o app.pdf 
	pandoc -V geometry:margin=1in smbkc.md app.md -o smbkc.html --bibliography=../references/Gmacs.bib

clean:
	$(RM) smbkc.md 
	$(RM) app.md 
	$(RM) smbkc.Rmd
