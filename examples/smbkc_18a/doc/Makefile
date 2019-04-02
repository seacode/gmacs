ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: pdf 
# app clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: smbkc.Rmd 
#	cp smbkc.R smbkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("smbkc.Rmd") '
#knit("app.Rmd")
	pandoc -V geometry:margin=1in smbkc.md -o smbkc.pdf --bibliography=references/Gmacs.bib
	pandoc -V geometry:margin=1in smbkc.md -o smbkc.pdf 
	open smbkc.pdf

word: smbkc.Rmd 
#	cp smbkc.R smbkc.Rmd
	# R ${R_OPTS} -e 'library(knitr); knit("smbkc.Rmd"); knit("app.Rmd")'
	pandoc -V geometry:margin=1in smbkc.md -o smbkc.docx --bibliography=references/Gmacs.bib
	open smbkc.docx

app: app.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("app.Rmd")'
	pandoc -V geometry:margin=1in app.md -o app.pdf 
	open app.pdf

clean:
	$(RM) smbkc.md 
	$(RM) app.md 
