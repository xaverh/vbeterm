# vbeterm

PREFIX ?= /usr/local
CXX ?= c++
PKG_CONFIG ?= pkg-config

PKGS = vte-2.91 gtk+-3.0 gdk-3.0 x11 fontconfig

VBE_VERSION := $(shell git describe --tags --always --match '[0-9]*' --dirty 2>/dev/null || date +%F)

CPPFLAGS := -DPACKAGE_NAME=\"vbeterm\" -DPACKAGE_VERSION=\"$(VBE_VERSION)\" -DVERSION=\"$(VBE_VERSION)\"
CPPFLAGS += $(shell $(PKG_CONFIG) --cflags $(PKGS) 2>/dev/null)

CXXFLAGS := -std=gnu++23 -O2 -fdiagnostics-show-option -pipe -Wall -Wextra -Wformat -Wformat-security -Wfatal-errors -Wcast-align -Winline -Wno-unused-parameter -Wno-missing-field-initializers

UNAME_S := $(shell uname -s)
ifneq ($(UNAME_S),Darwin)
CXXFLAGS += -fstack-protector
CPPFLAGS += -D_FORTIFY_SOURCE=2
LDFLAGS += -Wl,-z,relro -Wl,-z,now
endif

LDLIBS := -lm $(shell $(PKG_CONFIG) --libs $(PKGS) 2>/dev/null)

all: vbeterm

vbeterm: src/term.cxx Makefile
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o $@ $< $(LDLIBS)

clean:
	rm -f vbeterm

install: vbeterm
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f vbeterm $(DESTDIR)$(PREFIX)/bin/vbeterm
	chmod 755 $(DESTDIR)$(PREFIX)/bin/vbeterm

.PHONY: all clean install
