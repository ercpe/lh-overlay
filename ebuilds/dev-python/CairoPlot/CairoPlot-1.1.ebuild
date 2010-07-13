# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="A python module to plot graphics in an easy and intuitive way"
HOMEPAGE="https://launchpad.net/cairoplot/"
SRC_URI="http://launchpad.net/cairoplot/${PV}/${PV}/+download/cairoplot-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2"
IUSE=""

RDEPEND="dev-python/pycairo"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "cairoplot-${PV}"
}

src_compile() {
	echo -n ""
}

src_install() {
	cd "cairoplot-${PV}"
	insinto $(python_get_sitedir)
	doins ${PN}.py || die
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}.py
}
