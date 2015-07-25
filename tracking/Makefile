
.PHONY: clean

resources/cmt:
	git clone -b quiet https://github.com/IDInteraction/CppMT.git
	cd CppMT && cmake .
	$(MAKE) -C CppMT
	mv CppMT/cmt resources/cmt

clean:
	rm -rf CppMT
	rm -f resources/cmt
