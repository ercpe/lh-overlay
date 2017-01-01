# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} pypy )

inherit distutils-r1

DESCRIPTION="Pure-python wrapper for libusb-1.0"
HOMEPAGE="https://github.com/vpelletier/python-libusb1"
SRC_URI="https://github.com/vpelletier/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/libusb:1"

python_test() {
	${EPYTHON} ./testUSB1.py || die
}