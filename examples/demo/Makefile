EXEC = gsmac
DIST = ../../src/build/debug/
ARGS = 

all: run

$(EXEC): $(DIST)$(EXEC).tpl
	cp $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

run: $(EXEC)
	./$(EXEC) $(ARGS)

clean:
	rm -f $(EXEC)
	rm -f admodel.*
	rm -f $(EXEC)  $(EXEC).[brpces]* *.rpt *.log variance
