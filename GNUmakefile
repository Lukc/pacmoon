.PHONY: all install dist clean

# NOTE: You currently need GNU make to be able to run this Makefile.

version = $(shell grep "^PACMOON_VERSION=" pacmoon | sed "s/^.*=//")
project = pacmoon-${version}

PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin
SHAREDIR ?= ${PREFIX}/share

# Nothing to be built. This is here only to avoid the unexpected `install` rule.
all: pacmoon

pacmoon:
	@echo " -- Generating pacmoon from pacmoon.in"
	@sed "s:@MODULES_DIR@:${SHAREDIR}/pacmoon:" pacmoon.in > pacmoon

install:
	@mkdir -p ${DESTDIR}${BINDIR}
	@echo " -- Installing pacmoon [755] in ${DESTDIR}${BINDIR}"
	@install -m755 pacmoon ${DESTDIR}${BINDIR}
	@mkdir -p ${DESTDIR}${SHAREDIR}/pacmoon
	@echo " -- Installing the pkgutils module [644] in ${DESTDIR}${SHAREDIR}/pacmoon"
	@install -m644 modules/pkgutils.zsh ${DESTDIR}${SHAREDIR}/pacmoon/pkgutils.zsh

clean:
	@echo " -- Removing pacmoon"
	@rm -f pacmoon

dist:
	@git archive --prefix=${project}/ -o ${project}.tar HEAD
	@echo " -- Building ${project}.tar.gz"
	@-gzip -c ${project}.tar > ${project}.tar.gz
	@echo " -- Building ${project}.tar.bz2"
	@-bzip2 -c ${project}.tar > ${project}.tar.bz2
	@echo " -- Building ${project}.tar.xz"
	@-xz -c ${project}.tar > ${project}.tar.xz
	@rm ${project}.tar

