
.PHONY: clean

CppMT/cmt:
	git clone -b quiet https://github.com/IDInteraction/CppMT.git
	cd CppMT && cmake .
	$(MAKE) -C CppMT

clean:
	rm -rf CppMT
