# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit python-r1

DESCRIPTION="Tool to automatically detect FLOSS licenses"
HOMEPAGE="https://ercpe.de/projects/license-finder"
SRC_URI="https://code.not-your-server.de/license-finder.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

src_prepare() {
	sed -i -e '1 s:^.*$:#!/usr/bin/env python:g' src/main.py || die
}

src_install() {
	python_foreach_impl python_newscript src/main.py ${PN}
}
