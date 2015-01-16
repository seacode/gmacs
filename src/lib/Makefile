# Name of archive.
OUTPUT:=libgmacs.a

# Portable makefiles (http://skramm.blogspot.com/2013/04/writing-portable-makefiles.html)
# Windows users: download http://gnuwin32.sourceforge.net/packages/make.htm
ifdef ComSpec
    RM=del /F /Q
else
    RM=rm -rf
endif

# Global source files from current dir.
SRCS:=$(wildcard *.cpp *.c *.cc *.cxx )

# Path to ADMB distribution directory
# export ADMB_HOME=/Users/stevenmartell1/admb-trunk/bin/dist

# Compiler
CXX:=clang++

# Compiler and linker flags.
CXXFLAGS:=-g -Wall -D__GNUDOS__ -Dlinux -DUSE_LAPLACE  \
	      -I.                                          \
	      -I$(ADMB_HOME)/include                       \
	      -I/usr/include/libxml2
LDFLAGS:= 

# Release specific flags.
RELEASE_CXXFLAGS:=-O3 -DOPT_LIB
RELEASE_LDFLAGS:= $(ADMB_HOME)/lib/libadmb-contribo.a -lxml2

# Debug specific flags.
DEBUG_CXXFLAGS:=-O0 -DSAFE_ALL
DEBUG_LDFLAGS:= $(ADMB_HOME)/lib/libadmb-contrib.a -lxml2


# ======================= END OF CONFIGURABLE THINGS ===========================
# Create debug & release list of object files as well as dep files.
BASEFILES:=$(basename $(SRCS))
DEBUG_OBJS:=$(addprefix bin/debug/,$(addsuffix .o,$(BASEFILES)))
RELEASE_OBJS:=$(addprefix bin/release/,$(addsuffix .o,$(BASEFILES)))
DEPFILES:=$(addprefix bin/deps/,$(addsuffix .d,$(BASEFILES)))

# Default to release bin.
all:  debug release


# Directory targets
bin/debug:
	@echo creating debug directory
	@mkdir -p bin/debug bin/deps

bin/release:
	@echo creating release directory
	@mkdir -p bin/release bin/deps

# Debug route.
.PHONY: debug
debug: CXXFLAGS+= $(DEBUG_CXXFLAGS)
debug: LDFLAGS+= $(DEBUG_LDFLAGS)
debug: bin/debug/$(OUTPUT)

bin/debug/$(OUTPUT): bin/debug $(DEBUG_OBJS)
	@echo 'linking ' bin/debug/$(OUTPUT)
	$(AR) -rs  $@ $(DEBUG_OBJS)
	# @$(CXX) -o bin/debug/$(OUTPUT) $(DEBUG_OBJS) $(LDFLAGS)

-include $(DEPFILES)

bin/debug/%.o : %.cpp
	@echo 'compiling ' $<
	@$(CXX) -c $(CXXFLAGS) $< -o $@
	@$(CXX) -MM $(CXXFLAGS) $< -o bin/deps/$*.d
	@mv -f bin/deps/$*.d bin/deps/$*.d.tmp
	@sed -e 's|.*:|bin/debug/$*.o:|' < bin/deps/$*.d.tmp \
	  > bin/deps/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < bin/deps/$*.d.tmp | fmt -1 \
	  | sed -e 's/^ *//' -e 's/$$/:/' >> bin/deps/$*.d
	@$(RM) -f bin/deps/$*.d.tmp	

# Release route.
.PHONY: release
release: CXXFLAGS+= $(RELEASE_CXXFLAGS)
release: LDFLAGS+= $(RELEASE_LDFLAGS)
release: bin/release/$(OUTPUT)

bin/release/$(OUTPUT): bin/release $(RELEASE_OBJS)
	@echo 'linking ' bin/release/$(OUTPUT)
	$(AR) -rs  $@ $(RELEASE_OBJS)
	# @$(CXX) -o bin/release/$(OUTPUT) $(RELEASE_OBJS) $(LDFLAGS)

bin/release/%.o : %.cpp
	@echo 'compiling ' $<
	@$(CXX) -c $(CXXFLAGS) $< -o $@
	@$(CXX) -MM $(CXXFLAGS) $< -o bin/deps/$*.d
	@mv -f bin/deps/$*.d bin/deps/$*.d.tmp
	@sed -e 's|.*:|bin/release/$*.o:|' < bin/deps/$*.d.tmp \
	  > bin/deps/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < bin/deps/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> bin/deps/$*.d
	@$(RM) -f bin/deps/$*.d.tmp

.PHONY: clean
clean:
	@echo 'removing bin directory'
	@$(RM) -rf bin