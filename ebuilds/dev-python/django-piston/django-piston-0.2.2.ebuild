# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A Django mini-framework creating APIs."
HOMEPAGE="http://bitbucket.org/jespern/django-piston/"
SRC_URI="http://bitbucket.org/jespern/${PN}/downloads/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
IUSE=""

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${PN}"
}

src_compile() {
	echo "" # dont ask me....
}

src_install() {
	cd "${PN}" # and this...
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/piston/
}
