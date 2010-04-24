# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Python module for retrieving WHOIS information of domains"
HOMEPAGE="http://code.google.com/p/pywhois/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${PF}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize pywhois
}
