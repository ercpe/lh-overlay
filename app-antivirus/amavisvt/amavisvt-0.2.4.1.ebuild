# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 pypy )

inherit distutils-r1

DESCRIPTION="Virustotal integration for amavisd-new"
HOMEPAGE="https://code.not-your-server.de/amavisvt.git/"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
		dev-python/python-memcached[${PYTHON_USEDEP}]
		dev-python/filemagic[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	python_foreach_impl python_newscript "${S}"/amavisvt/__main__.py "amavisvt"

	dodoc "${S}"/amavisvt_example.cfg

	insinto /etc
	newins ${PN}_example.cfg ${PN}.cfg
}
