#! /bin/sh
# Copyright (C) 2011-2023 Free Software Foundation, Inc.
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# The stub rules emitted to work around the "deleted header problem"
# for '.m4' files shouldn't prevent "make" from diagnosing a missing
# required '.m4' file from a distribution tarball.
# See discussion about automake bug#9768.
# See also sister test 'dist-missing-included-m4.sh'.

. test-init.sh

cat >> configure.ac <<'END'
m4_pattern_forbid([^MY_])
MY_FOOBAR || exit 1
MY_ZARDOZ || exit 1
AC_OUTPUT
END

mkdir m4
echo 'AC_DEFUN([MY_FOOBAR], [:])' > m4/foobar.m4
echo 'AC_DEFUN([MY_ZARDOZ], [:])' > m4/zardoz.m4

echo 'ACLOCAL_AMFLAGS = -I m4' > Makefile.am

$ACLOCAL -I m4
$AUTOCONF
$AUTOMAKE

./configure

# A faulty distribution tarball, with a required '.m4' file missing.
# Building from it should fail, both for in-tree and VPATH builds.
ocwd=$(pwd) || fatal_ "cannot get current working directory"
for vpath in false :; do
  $MAKE distdir
  test -f $distdir/m4/zardoz.m4 # Sanity check.
  rm -f $distdir/m4/zardoz.m4
  if $vpath; then
    # We can't just build in a subdirectory of $distdir, otherwise
    # we'll hit automake bug#10111.
    mkdir vpath-distcheck
    cd vpath-distcheck
    ../$distdir/configure
  else
    cd $distdir
    ./configure
  fi
  run_make -e FAIL -M
  # This error will come from autoconf, not make, so we can be stricter
  # in our grepping of it.
  grep 'possibly undefined .*MY_ZARDOZ' output
  grep 'MY_FOOBAR' output && exit 1 # No spurious error, please.
  cd "$ocwd" || fatal_ "cannot chdir back to top-level test directory"
done

:
