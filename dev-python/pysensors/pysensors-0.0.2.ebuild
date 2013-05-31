# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="sensors"

inherit distutils

DESCRIPTION="Python bindings for libsensors via ctypes."
HOMEPAGE="http://pypi.python.org/pypi/PySensors/"
SRC_URI="mirror://pypi/P/PySensors/PySensors-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

S="${WORKDIR}"/PySensors-${PV}
