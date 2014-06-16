EXEC = gmacs
DIST = ../../src/build/debug/

all: run

$(EXEC): $(DIST)$(EXEC).tpl
	cp $(DIST)$(EXEC) $@

$(DIST)$(EXEC).tpl:
	$(MAKE) --directory=../../src

run: $(EXEC)
	./$(EXEC)

clean:
	rm -f gmacs