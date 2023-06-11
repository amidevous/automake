## -*- makefile-automake -*-
## Copyright (C) 1995-2018 Free Software Foundation, Inc.
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## ----------------------------------- ##
##  The automake and aclocal scripts.  ##
## ----------------------------------- ##

bin_SCRIPTS = bin/automake bin/aclocal
nodist_noinst_SCRIPTS += \
  bin/aclocal-$(APIVERSION) \
  bin/automake-$(APIVERSION)

CLEANFILES += \
  $(bin_SCRIPTS) \
  bin/aclocal-$(APIVERSION) \
  bin/automake-$(APIVERSION)

# Used by maintainer checks and such.
automake_in = $(srcdir)/bin/automake.in
aclocal_in  = $(srcdir)/bin/aclocal.in
automake_script = bin/automake
aclocal_script  = bin/aclocal

AUTOMAKESOURCES = $(automake_in) $(aclocal_in)
TAGS_FILES += $(AUTOMAKESOURCES)
EXTRA_DIST += $(AUTOMAKESOURCES)

# Make versioned links.  We only run the transform on the root name;
# then we make a versioned link with the transformed base name.  This
# seemed like the most reasonable approach.
install-exec-hook:
	@$(POST_INSTALL)
	@for p in $(bin_SCRIPTS); do \
	  f=`echo $$p | sed -e 's,.*/,,' -e '$(transform)'`; \
	  fv="$$f-$(APIVERSION)"; \
	  rm -f "$(DESTDIR)$(bindir)/$$fv"; \
	  echo " $(LN) '$(DESTDIR)$(bindir)/$$f' '$(DESTDIR)$(bindir)/$$fv'"; \
	  $(LN) "$(DESTDIR)$(bindir)/$$f" "$(DESTDIR)$(bindir)/$$fv"; \
	done

uninstall-hook:
	@for p in $(bin_SCRIPTS); do \
	  f=`echo $$p | sed -e 's,.*/,,' -e '$(transform)'`; \
	  fv="$$f-$(APIVERSION)"; \
	  rm -f "$(DESTDIR)$(bindir)/$$fv"; \
	done

# These files depend on Makefile so they are rebuilt if $(VERSION),
# $(datadir) or other do_subst'ituted variables change.
bin/automake: bin/automake.in
bin/aclocal: bin/aclocal.in
bin/automake bin/aclocal: Makefile
	$(AM_V_GEN)rm -f $@ $@-t $@-t2 \
	  && $(MKDIR_P) $(@D) \
## Common substitutions.
	  && in=$@.in && $(do_subst) <$(srcdir)/$$in >$@-t \
## We can't use '$(generated_file_finalize)' here, because currently
## Automake contains occurrences of unexpanded @substitutions@ in
## comments, and that is perfectly legit.
	  && chmod a+x,a-w $@-t && mv -f $@-t $@

bin/aclocal-$(APIVERSION): bin/aclocal
	$(AM_V_GEN) rm -f $@; \
	$(LN) bin/aclocal $@

bin/automake-$(APIVERSION): bin/automake
	$(AM_V_GEN) rm -f $@; \
	$(LN) bin/automake $@

# vim: ft=automake noet
