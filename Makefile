.PHONY: install dist

version = $(shell grep "^PACMOON_VERSION=" pacmoon | sed "s/^.*=//")
project = pacmoon-${version}

PREFIX ?= /usr
BINDIR ?= ${PREFIX}/bin
SHAREDIR ?= ${PREFIX}/share

# Nothing to be built. This is here only to avoid the unexpected `install` rule.
all:

install:
	@mkdir -p ${DESTDIR}${BINDIR}
	@echo " -- Installing pacmoon [755] in ${DESTDIR}${BINDIR}"
	@install -m755 pacmoon ${DESTDIR}${BINDIR}
	@mkdir -p ${DESTDIR}${SHAREDIR}/pacmoon

dist:
	@git archive --prefix=${project}/ -o ${project}.tar HEAD
	@echo " -- Building ${project}.tar.gz"
	@-gzip -c ${project}.tar > ${project}.tar.gz
	@echo " -- Building ${project}.tar.bz2"
	@-bzip2 -c ${project}.tar > ${project}.tar.bz2
	@echo " -- Building ${project}.tar.xz"
	@-xz -c ${project}.tar > ${project}.tar.xz
	@rm ${project}.tar

