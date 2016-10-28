# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

#DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 systemd

DESCRIPTION="A web terminal based on websocket and tornado"
HOMEPAGE="http://pypi.python.org/pypi/butterfly https://github.com/paradoxxxzero/butterfly"
SRC_URI="
	mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	https://raw.githubusercontent.com/paradoxxxzero/butterfly/master/butterfly.service -> ${P}.service
	https://raw.githubusercontent.com/paradoxxxzero/butterfly/master/butterfly.socket -> ${P}.socket
	"

LICENSE="GPL-3+ OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	>=www-servers/tornado-3.2[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all

	systemd_newunit "${DISTDIR}"/${P}.service ${PN}.service
	systemd_newunit "${DISTDIR}"/${P}.socket ${PN}.socket
}
