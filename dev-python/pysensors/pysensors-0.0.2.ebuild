# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python bindings for libsensors via ctypes."
HOMEPAGE="http://pypi.python.org/pypi/PySensors/"
SRC_URI="mirror://pypi/P/PySensors/PySensors-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"/PySensors-${PV}
