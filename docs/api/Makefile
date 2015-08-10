.PHONY: default clean


default: Doxyfile
	tpl2dox.sh ../../src/gmacs.tpl
	doxygen Doxyfile
	@cd html; git add .
	@cd html; git commit -ma"Updates to API"
	@cd html; git push origin gh-pages


clean:
	@cd html; rm -rf d* *.* search
