# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="unittest-based test runner with Ant/JUnit like XML reporting"
HOMEPAGE="https://github.com/xmlrunner/unittest-xml-reporting"
SRC_URI="https://github.com/xmlrunner/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPENDS=">dev-python/six-1.4.0[${PYTHON_USEDEP}]"
DEPENDS="${CDEPENDS}"
RDEPENDS="${CDEPENDS}"
