# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Line-by-line profiler"
HOMEPAGE="https://github.com/rkern/line_profiler"
SRC_URI="mirror://pypi/l/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE=""

x_python_test() {
	"${PYTHON}" -m unittest discover "${S}"/test/ || die "Tests failed with ${EPYTHON}"
}