#Makefile for building and running the LSMR model on a Linux or Mac OSX
EXEC=LSMR
TPL=$(EXEC).tpl
CTL=simLSMR.ctl
DAT=LSMR.dat
ARG=

all: $(EXEC) $(EXEC).rep

$(EXEC): $(TPL)
	admb $(EXEC)

$(EXEC).rep: $(TPL) $(DAT) $(CTL)
	./$(EXEC) -ind $(DAT) $(ARG)

clean:
	rm -f $(EXEC) *.eva *.log *.rpt *.htp *.cor *.par *.r* *.[pbhem]* 
	rm -f *.rep *.bar *.std $(EXEC).cpp admodel.* variance