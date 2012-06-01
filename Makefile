all: vmx

vmx: $(VMX_TARGETS)
	$(MAKE) -C vmx all

clean:
	$(MAKE) -C vmx clean
	rm -f *.tar*

tarball: vmx.tar.bz2
vmx.tar.bz2: vmx
	tar cjf $@ $< --exclude=Makefile --exclude='*.c'

.PHONY: all clean tarball vmx
