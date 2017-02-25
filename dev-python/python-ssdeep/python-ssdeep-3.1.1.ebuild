# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python wrapper for the ssdeep library"
HOMEPAGE="https://github.com/DinoTools/python-ssdeep"
SRC_URI="https://github.com/DinoTools/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPENDS="app-crypt/ssdeep
		dev-python/cffi[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"
DEPENDS="${CDEPENDS}"
RDEPENDS="${CDEPENDS}"

src_prepare() {
	default
	# never fall back to the bundled ssdeep
	rm -r "${S}"/ssdeep-lib || die
}