#!/bin/sh
# Copyright (C) 2002-2012 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Make sure .PHONY can be given dependencies several times.
# From Ralf Corsepius.

. ./defs || Exit 1

cat >Makefile.am << 'EOF'
.PHONY: foo
.PHONY: bar
EOF

$ACLOCAL
$AUTOMAKE
test `$FGREP .PHONY: Makefile.in | wc -l` = 3