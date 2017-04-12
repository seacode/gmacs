ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: app pdf clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

app: app.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("app.Rmd")'
	pandoc -V geometry:margin=1in app.md -o app.pdf 

pdf: bbrkc.Rmd
	R ${R_OPTS} -e 'library(knitr); knit("bbrkc.Rmd");'
	pandoc -V geometry:margin=1in bbrkc.md -o bbrkc.pdf --bibliography=../references/Gmacs.bib --latex-engine=xelatex

clean:
	$(RM) bbrkc.md 
	$(RM) app.md 
