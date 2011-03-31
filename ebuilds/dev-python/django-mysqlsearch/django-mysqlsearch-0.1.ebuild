# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A django application for building search functionality based on the mysql fulltext indexes"
HOMEPAGE="http://www.j-schmitz.net/projects/django-mysqlsearch/"
SRC_URI="http://www.j-schmitz.net/releases/django-mysqlsearch/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">dev-python/django-1.2"
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
	python_mod_optimize $(python_get_sitedir)/mysqlsearch/
}
