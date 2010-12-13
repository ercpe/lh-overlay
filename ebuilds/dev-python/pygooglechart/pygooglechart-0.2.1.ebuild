# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="pygooglechart is a complete Python wrapper for the Google Chart API."
HOMEPAGE="http://pygooglechart.slowchop.com/"
SRC_URI="http://pygooglechart.slowchop.com/files/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${P}"
}

src_compile() {
	echo "" # dont ask me....
}

src_install() {
	#cd "${P}" # and this...
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}.py
}
