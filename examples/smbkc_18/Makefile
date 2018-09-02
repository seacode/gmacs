# make -j N will do N simultaneous mods (in this case 3...)
NMODS:=5
NUMBERS:=$(shell seq 1 ${NMODS})
JOBS:=$(addprefix model_,${NUMBERS})
DEL:=admodel.cov admodel.dep admodel.hes checkfile.rep fmin.log gmacs.b0* gmacs.bar gmacs.cor gmacs.eva gmacs.log gmacs.p0* gmacs.par gmacs.r0* gmacs.rep gmacs.std gmacs_files_in.dat gmacs_in.ctl gmacs_in.dat gradient.* mcout.rep variance
MODS_DESC=Models to be run
ARGS:=

ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

.PHONY: all ${JOBS} clean

all: ${JOBS} ; echo "$@ success" ${JOBS} 
${JOBS}: job%: ; cd $* ; make ${ARGS} ; cd ..;
