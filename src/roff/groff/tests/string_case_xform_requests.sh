#!/usr/bin/env bash
#
# Copyright (C) 2019-2020 Free Software Foundation, Inc.
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

expected="Résumé résumé RÉSUMÉ"

actual=$("$groff" -Tutf8 <<EOF
.pl 1v
.ds resume R\\['e]sum\\['e]\\\"
\\*[resume]
.stringdown resume
\\*[resume]
.stringup resume
\\*[resume]
EOF
)

diff -u <(echo "$expected") <(echo "$actual")
