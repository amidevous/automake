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

## ---------------------------------------------------- ##
##  Private perl modules used by automake and aclocal.  ##
## ---------------------------------------------------- ##

perllibdir = $(pkgvdatadir)/Automake

dist_perllib_DATA = \
  lib/Automake/ChannelDefs.pm \
  lib/Automake/Channels.pm \
  lib/Automake/Condition.pm \
  lib/Automake/Configure_ac.pm \
  lib/Automake/DisjConditions.pm \
  lib/Automake/FileUtils.pm \
  lib/Automake/General.pm \
  lib/Automake/Getopt.pm \
  lib/Automake/Item.pm \
  lib/Automake/ItemDef.pm \
  lib/Automake/Language.pm \
  lib/Automake/Location.pm \
  lib/Automake/Options.pm \
  lib/Automake/Rule.pm \
  lib/Automake/RuleDef.pm \
  lib/Automake/Variable.pm \
  lib/Automake/VarDef.pm \
  lib/Automake/Version.pm \
  lib/Automake/XFile.pm \
  lib/Automake/Wrap.pm

nodist_perllib_DATA = lib/Automake/Config.pm
CLEANFILES += $(nodist_perllib_DATA)

lib/Automake/Config.pm: lib/Automake/Config.in Makefile
	$(AM_V_at)rm -f $@ $@-t
	$(AM_V_at)$(MKDIR_P) lib/Automake
	$(AM_V_GEN)in=Config.in \
	  && $(do_subst) <$(srcdir)/lib/Automake/Config.in >$@-t
	$(generated_file_finalize)
EXTRA_DIST += lib/Automake/Config.in

# vim: ft=automake noet
