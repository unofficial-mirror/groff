#!/bin/sh
#
# Copyright (C) 2021 Free Software Foundation, Inc.
#
# This file is part of groff.
#
# groff is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# groff is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

groff="${abs_top_builddir:-.}/test-groff"

set -e

# Regression-test Savannah #60874.
#
# groff should start up in any supported locale, in compatibility mode
# or not, without producing diagnostics.

for COMPAT in "" -C
do
  for LOCALE in cs de en fr it ja sv zh
  do
    echo "testing LANG=$LOCALE; COMPAT=\"$COMPAT\""
    OUTPUT=$(LANG=$LOCALE "$groff" -ww "$COMPAT" < /dev/null 2>&1)
    test -z "$OUTPUT"
  done
done