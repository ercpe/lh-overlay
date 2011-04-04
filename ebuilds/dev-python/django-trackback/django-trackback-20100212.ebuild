# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A django application for sending and receiving trackbacks"
HOMEPAGE="http://code.google.com/p/django-trackback/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">dev-python/django-1.2"
DEPEND="${RDEPEND}"

src_install() {
	#cd "${P}" # and this...
	distutils_src_install
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/trackback/
}
