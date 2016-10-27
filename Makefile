all:
	$(MAKE) --directory=./src

test:
	# $(MAKE) --directory=./examples/demo
	 $(MAKE) --directory=./examples/bbrkc/TwoSex
	#$(MAKE) --directory=./examples/bbrkc/M1

clean:
	$(MAKE) clean --directory=./src
