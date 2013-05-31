# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="A python module to plot graphics in an easy and intuitive way"
HOMEPAGE="https://launchpad.net/cairoplot/"
SRC_URI="http://launchpad.net/cairoplot/${PV}/${PV}/+download/cairoplot-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2"
IUSE=""

RDEPEND="dev-python/pycairo"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/cairoplot-${PV}

src_compile() {
	echo -n ""
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		doins ${PN}.py
	}
	python_execute_function installation
	dodoc NEWS TODO || die
}

pkg_postinst() {
	python_mod_optimize ${PN}.py
}

pkg_postrm() {
	python_mod_cleanup ${PN}.py
}
