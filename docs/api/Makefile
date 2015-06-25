.PHONY: default clean


default: Doxyfile
	doxygen Doxyfile
	@cd html; git add .
	@cd html; git commit -ma"Updates to API"
	@cd html; git push origin gh-pages


clean:
	#rm -rf html

	