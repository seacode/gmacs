ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

all: pdf app clean

R_OPTS=--no-save --no-restore --no-init-file --no-site-file

pdf: AppC.Rmd 
	R ${R_OPTS} -e 'library(knitr); knit("AppC.Rmd")' 
	pandoc -V geometry:margin=1in AppC.md -o AppC.pdf 
	open AppC.pdf

clean:
	$(RM) AppC.md 

