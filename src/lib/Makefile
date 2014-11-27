OUTPUT:=libgmacs.a
# export ADMB_HOME=/Users/steveyou nmartell1/admb-trunk/build/dist

CXX:=clang++

# Compiler and linker flags.
CXXFLAGS:=-g -Wall -D__GNUDOS__ -Dlinux -DUSE_LAPLACE  \
					-I.                                          \
					-I$(ADMB_HOME)/include                       \
					-I$(ADMB_HOME)/contrib/include               \
					-I/usr/include/libxml2

# Debug specific flags.
DEBUG_CXXFLAGS:=-O0 -DSAFE_ALL
DEBUG_LDFLAGS:= $(ADMB_HOME)/lib/libadmb-contrib.a               \
	           

# Release specific flags.
RELEASE_CXXFLAGS:=-O3 -DOPT_LIB
RELEASE_LDFLAGS:= $(ADMB_HOME)/lib/libadmb-contribo.a            \
	              


# Global source files from current dir.
SRCS:=$(wildcard *.cpp *.c *.cc *.cxx )


# ======================= END OF CONFIGURABLE THINGS ===========================
OBJS:=$(SRCS:.cpp=.obj)
BASEFILES:=$(basename $(SRCS))
DEBUG_OBJS:=$(addprefix ../build/debug/,$(OBJS))
RELEASE_OBJS:=$(addprefix ../build/release/,$(OBJS))

all: debug release

# all:
# 	$(MAKE) libcstar.a

# libcstar.a: $(SRCS)
# 	$(ADMB_HOME)/admb -c $^
# 	$(AR) -rs  $@ $(OBJS)


# Directory targets
../build/debug:
	@echo creating debug Directory
	@mkdir -p ../build/debug ../build/deps

../build/release:
	@echo creating release directory
	@mkdir -p ../build/release ../build/deps


# ================================ DEBUG RECIPE ================================
.PHONY: debug
debug: CXXFLAGS+= $(DEBUG_CXXFLAGS)
debug: LDFLAGS += $(DEBUG_LDFLAGS)
debug: ../build/debug/$(OUTPUT)

../build/debug/$(OUTPUT): ../build/debug/ $(DEBUG_OBJS)
	@echo 'linking' ../build/debug/$(OUTPUT)
	$(AR) -rs $@ $(DEBUG_OBJS) $(LDFLAGS)

-include $(DEPFILES)

../build/debug/%.obj : %.cpp
	@echo 'compiling ' $<
	@$(CXX) -c  $(CXXFLAGS) $< -o $@
	@$(CXX) -MM $(CXXFLAGS) $< -o ../build/deps/$*.d
	@mv -f ../build/deps/$*.d ../build/deps/$*.d.tmp
	@sed -e 's|.*:|../build/release/$*.o:|' < ../build/deps/$*.d.tmp \
	  > ../build/deps/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < ../build/deps/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> ../build/deps/$*.d
	@rm -f ../build/deps/$*.d.tmp

# =============================== RELEASE RECIPE ===============================
.PHONY: release
release: CXXFLAGS+= $(RELEASE_CXXFLAGS)
release: LDFLAGS += $(RELEASE_LDFLAGS)
release: ../build/release/$(OUTPUT)

../build/release/$(OUTPUT): ../build/release/ $(RELEASE_OBJS)
	@echo 'linking' ../build/release/$(OUTPUT)
	$(AR) -rs $@ $(RELEASE_OBJS) $(LDFLAGS)

../build/release/%.obj : %.cpp
	@echo 'compiling ' $<
	@$(CXX) -c  $(CXXFLAGS) $< -o $@
	@$(CXX) -MM $(CXXFLAGS) $< -o ../build/deps/$*.d
	@mv -f ../build/deps/$*.d ../build/deps/$*.d.tmp
	@sed -e 's|.*:|../build/release/$*.o:|' < ../build/deps/$*.d.tmp \
	  > ../build/deps/$*.d
	@sed -e 's/.*://' -e 's/\\$$//' < ../build/deps/$*.d.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> ../build/deps/$*.d
	@rm -f ../build/deps/$*.d.tmp


.PHONY: clean
clean:
	@echo 'removing build directory'
	@rm -rf ../build