#! /bin/sh
# Copyright (C) 2011-2012 Free Software Foundation, Inc.
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

# Make sure that invalid entries in TEST_EXTENSIONS are diagnosed at
# make runtime.  See automake bug#9400.

. ./defs || Exit 1

echo AC_OUTPUT >> configure.ac

cat > Makefile.am << 'END'
TESTS =
TEST_EXTENSIONS = mu x1 .foo _ x2
END

$ACLOCAL
$AUTOCONF
$AUTOMAKE -a

./configure

$MAKE 2>stderr && { cat stderr >&2; Exit 1; }
cat stderr >&2
for suf in mu x1 _ x2; do
  $FGREP "invalid test extension: '$suf'" stderr
done

# Verify that we don't report valid suffixes, even if intermixed
# with invalid ones.
grep 'invalid.*extension.*foo' stderr && Exit 1

: