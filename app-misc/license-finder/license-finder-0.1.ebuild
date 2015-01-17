# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit python-r1 vcs-snapshot

DESCRIPTION="Tool to automatically detect FLOSS licenses"
HOMEPAGE="https://ercpe.de/projects/license-finder"
SRC_URI="http://repos.j-schmitz.net/gitweb/?p=license-finder.git;a=snapshot;h=c0b69b99a4f6965533a49fce1425cf93593cd77e;sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=""

src_prepare() {
	sed -i -e '1 s:^.*$:#!/usr/bin/env python:g' src/main.py || die
}

src_install() {
	python_foreach_impl python_newscript src/main.py ${PN}
}