# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A user-registration application for Django."
HOMEPAGE="http://www.bitbucket.org/ubernostrum/django-registration/"
SRC_URI="http://www.bitbucket.org/ubernostrum/${PN}/get/v${PV}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="as-is" # sorry, dont know
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
	python_mod_optimize $(python_get_sitedir)/registration/
}
