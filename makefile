all:
	$(MAKE) --directory=./src

test:
	$(MAKE) --directory=./examples/demo

clean:
	$(MAKE) clean --directory=./src
