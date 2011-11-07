# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.1

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="sensors"

inherit distutils

DESCRIPTION="Python bindings for libsensors.so from the lm-sensors project via ctypes. Trying to support the last two libsensors APIs — versions 3 and 4."
HOMEPAGE="http://pypi.python.org/pypi/PySensors/"
SRC_URI="mirror://pypi/P/PySensors/PySensors-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

S="${WORKDIR}"/PySensors-${PV}