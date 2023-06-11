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

## ------------------------------ ##
##  Automake-provided m4 macros.  ##
## ------------------------------ ##

system_acdir = @system_acdir@
automake_acdir = @automake_acdir@

dist_automake_ac_DATA = \
  m4/amversion.m4 \
  m4/ar-lib.m4 \
  m4/as.m4 \
  m4/auxdir.m4 \
  m4/cond.m4 \
  m4/cond-if.m4 \
  m4/depend.m4 \
  m4/depout.m4 \
  m4/dmalloc.m4 \
  m4/extra-recurs.m4 \
  m4/gcj.m4 \
  m4/init.m4 \
  m4/install-sh.m4 \
  m4/lead-dot.m4 \
  m4/lex.m4 \
  m4/lispdir.m4 \
  m4/maintainer.m4 \
  m4/make.m4 \
  m4/missing.m4 \
  m4/mkdirp.m4 \
  m4/obsolete.m4 \
  m4/options.m4 \
  m4/python.m4 \
  m4/prog-cc-c-o.m4 \
  m4/runlog.m4 \
  m4/sanity.m4 \
  m4/silent.m4 \
  m4/strip.m4 \
  m4/substnot.m4 \
  m4/tar.m4 \
  m4/upc.m4 \
  m4/vala.m4

dist_system_ac_DATA = m4/acdir/README

automake_internal_acdir = $(automake_acdir)/internal
dist_automake_internal_ac_DATA = m4/internal/ac-config-macro-dirs.m4

# We build amversion.m4 here, instead of from config.status,
# because config.status is rerun each time one of configure's
# dependencies change and amversion.m4 happens to be a configure
# dependency.  configure and amversion.m4 would be rebuilt in
# loop otherwise.
# Use '$(top_srcdir)' for the benefit of non-GNU makes: this is
# how amversion.m4 appears in our dependencies.
$(top_srcdir)/m4/amversion.m4: $(srcdir)/configure.ac \
                                $(srcdir)/m4/amversion.in
	$(AM_V_at)rm -f $@-t $@
	$(AM_V_GEN)in=amversion.in \
	  && $(do_subst) <$(srcdir)/m4/amversion.in >$@-t
	$(generated_file_finalize)
EXTRA_DIST += m4/amversion.in

# vim: ft=automake noet
