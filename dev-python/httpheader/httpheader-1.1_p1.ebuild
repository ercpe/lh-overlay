# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit python-r1 vcs-snapshot

DESCRIPTION="Python module to deal with HTTP headers and content negotiation"
HOMEPAGE="http://deron.meranda.us/python/httpheader/ https://github.com/dmeranda/httpheader"
SRC_URI="https://github.com/dmeranda/httpheader/archive/release-${PV/_p1/}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S="${WORKDIR}/${P}"

src_prepare() {
	epatch "${FILESDIR}"/${P/_p1/}-python3.patch
}

src_compile() {
	use doc && make pydoc
}

src_install() {
	python_foreach_impl python_domodule ${PN}.py

	use doc && dodoc ${PN}.html
}