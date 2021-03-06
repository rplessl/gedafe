.SUFFIXES:
.SUFFIXES: .c .o .pl .pm .pod .html .man .wml .1 .txt
SHELL=/bin/sh

MAJOR  = 1
MINOR  = 4
MMINOR = 2
VERSION = $(MAJOR).$(MINOR).$(MMINOR)

GNUTAR = tar
TARFILE = gedafe-$(VERSION).tar.gz

tarball: doc
	shtool mkdir -p gedafe-$(VERSION)
	$(GNUTAR) -T MANIFEST -cf - | (cd gedafe-$(VERSION) && $(GNUTAR) xf -)
	$(GNUTAR) --mode=g-s -czvf pub/$(TARFILE) gedafe-$(VERSION)
	rm -rf gedafe-$(VERSION)
	
release: release-tag tarball

release-tag:
	git tag v$(MAJOR)_$(MINOR)_$(MMINOR)

release-tag-force:
	git tag -F v$(MAJOR)_$(MINOR)_$(MMINOR)

doc: doc/gedafe-sql.txt doc/gedafe-user.txt doc/cpptemplate.txt \
     doc/gedafe-pearls.txt doc/gedafe-javascript.txt doc/gedafe-oysters.txt \
     doc/gedafe-search.txt doc/gedafe-widgets.txt

doc/cpptemplate.txt:
	pod2man --release=0.3 --center=gedafe lib/perl/Text/CPPTemplate.pm >pod2txt.tmp
	groff -man -Tascii -P-u -P-b -P-o pod2txt.tmp > $@
	rm pod2txt.tmp

.pod.txt:
	pod2man --release=$(VERSION) --center=gedafe $<  >pod2txt.tmp
	groff -man -Tascii -P-u -P-b -P-o pod2txt.tmp > $@
	rm pod2txt.tmp

.PHONY: release doc tarball release-tag release-tag-force
