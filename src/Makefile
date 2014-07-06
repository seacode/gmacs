# A Generic Makefile for ADMB programs that also includes additonal libraries.
# Developed for Mac OSx using the clang++ compiler
# Author: Steve Martell & John Sibert
# —————————————————————— INSTRUCTIONS ———————————————————————— #
# 1. Set the EXEC variable to the name of the program.         #
# 2. List additional .cpp files required by EXEC in SRCS macro #
# 3. Set the ADMB_HOME path to your distribution of ADMB.      #
# 4. To make executables with ADMB "safe" library type: make   #
# 5. Optimized executables type: make OPT=TRUE                 #
# ———————————————————————————————————————————————————————————— #
EXEC = gsmac
SRCS = $(EXEC).cpp #multinomial.cpp 
OBJS = $(SRCS:.cpp=.o)
TPLS = $(EXEC).tpl
DEPS = $(SRCS:.cpp=.depends)

# Export the path to your ADMB dist directory
export ADMB_HOME=/Users/stevenmartell1/admb-trunk/build/dist

# establish the C++ compiler (on Mac OSX use clang++)
CC=clang
CXX=clang++
# and linker
LL = $(CC)
LD = $(CXX)
# Remove macro
RM=rm -f

# identify some extra file name suffixes
.SUFFIXES: .tpl .cpp .o .obj

# tell make not to delete these intermediate targets
.PRECIOUS: %.cpp %.o %.obj

# make some special PHONY targets
.PHONY: all help rules clean

# set up ADMB flags and appropriate libraries
# make the "safe" version by default
# to make "the optimized" version, type  `make OPT=TRUE
ifeq ($(OPT),TRUE)
  CC_OPT = -O3 -DOPT_LIB
  LDFLAGS = -O3 
  LDLIBS  = $(ADMB_HOME)/lib/libadmbo.a $(ADMB_HOME)/contrib/lib/libcontribo.a ../../CSTAR/src/libcstar.a
else
  CC_OPT = -O3 -DSAFE_ALL
  LDFLAGS = -O3 -g
  LDLIBS  = $(ADMB_HOME)/lib/libadmb.a $(ADMB_HOME)/contrib/lib/libcontrib.a ../../CSTAR/src/libcstar.a
endif

# set general compiler flags
CXXFLAGS = $(CC_OPT) -D__GNUDOS__ -Dlinux -DUSE_LAPLACE  -I. -I$(ADMB_HOME)/include -I$(ADMB_HOME)/contrib/include 

# this is the default target
all: $(EXEC)

# link the object file into the executable 
$(EXEC): $(OBJS)
	$(LD) $(LDFLAGS) -o  $@ $(OBJS) $(LDLIBS)


# Advanced Auto Dependency Generation
# Check compiler options for generating phony targets (-MP -MD for clang compiler on OSX)
%.o : %.cpp
	$(CXX) -MP -MD -c -o $@ $< $(CXXFLAGS)

-include $(OBJS:%.o=%.d)

# Build the cpp file from the tpl
$(EXEC).cpp: $(TPLS)
	$(ADMB_HOME)/bin/tpl2cpp $(TPLS:.tpl=)



clean: 
	$(RM) $(OBJS) $(EXEC).cpp


# generate some information about what your are doing
rules:
	@echo EXEC = $(EXEC)
	@echo OBJS = $(OBJS)
	@echo SRCS = $(SRCS)
	@echo TPLS = $(TPLS)
	@echo OPT = $(OPT)
	@echo CC_OPT = $(CC_OPT)
	@echo PWD = $(PWD)
	@echo ADMB_HOME = $(ADMB_HOME)
	@echo CC = $(CC)
	$(CC) --version
	@echo LD = $(LD)
	@echo CXXFLAGS = $(CXXFLAGS)
	@echo LDFLAGS = $(LDFLAGS)


# Some help for the naive
help:
	@echo Set:   EXEC target to the BaseName of your tpl script.
	@echo Usage: make <OPT=TRUE>
	@echo        specify OPT=TRUE to build optimized version



