ARCH     = ia32
EFIROOT  = /usr
HDRROOT  = $(EFIROOT)/include/efi
INCLUDES = -I. -I$(HDRROOT) -I$(HDRROOT)/$(ARCH) -I$(HDRROOT)/protocol

CRTOBJS  = $(EFIROOT)/lib/crt0-efi-$(ARCH).o
CFLAGS = -O2 -fpic -Wall -fshort-wchar -fno-strict-aliasing -fno-merge-constants \
	-fno-stack-protector
CPPFLAGS = -DCONFIG_$(PARCH)
FORMAT   = efi-app-$(ARCH)
LDFLAGS  = -nostdlib
LDSCRIPT = $(EFIROOT)/lib/elf_$(ARCH)_efi.lds
LDFLAGS += -T $(LDSCRIPT) -shared -Bsymbolic -L$(EFIROOT)/lib $(CRTOBJS)
LOADLIBS = -lefi -lgnuefi $(shell $(CC) -print-libgcc-file-name)

CC := gcc
AS := as
LD := ld
AR := ar
RANLIB := ranlib
OBJCOPY := objcopy

# Rules
#
%.efi: %.so
	$(OBJCOPY) -j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .rel \
                   -j .rela -j .reloc --target=$(FORMAT) $*.so $@

%.so: %.o
	$(LD) $(LDFLAGS) $^ -o $@ $(LOADLIBS)

%.o: %.c
	$(CC) $(INCLUDES) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

# Targets
#
SOURCES = $(wildcard *.c)
TARGETS = $(SOURCES:.c=.efi)

all: $(TARGETS)

clean:
	rm -f ./*.so
	rm -f ./*.o
	rm -f ./*.efi

.DEFAULT_GOAL: all
.PHONY: clean
