
.PHONY: clean

CppMT/cmt:
	git clone -b idi-merged https://github.com/IDInteraction/CppMT.git
	cd CppMT && cmake .
	$(MAKE) -C CppMT

clean:
	rm -rf CppMT
