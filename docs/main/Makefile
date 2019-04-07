ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: pdf clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: gmacs_doc.Rmd 
#	cp smbkc.R smbkc.Rmd
	#R ${R_OPTS} -e 'library(knitr); knit("gmacs_doc.Rmd")'
	#pandoc -V geometry:margin=1in gmacs_doc.md -o gmacs_doc.pdf --latex-engine=xelatex --template my.tex 
	#open gmacs_doc.pdf
	R ${R_OPTS} -e 'library(knitr); knit("Model.Rmd")'
	pandoc -V geometry:margin=1in Model.md -o Model.pdf --latex-engine=xelatex --template my.tex 
	open Model.pdf
	# pandoc -V geometry:margin=1in gmacs_doc.md -o gmacs_doc.pdf --bibliography=../references/Gmacs.bib
	# pandoc -V geometry:margin=1in gmacs_doc.md -o gmacs_doc.html --bibliography=../references/Gmacs.bib

clean:
	$(RM) gmacs_doc.md 
	$(RM) Model.md 

