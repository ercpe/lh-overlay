# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="PKCS#5 v2.0 PBKDF2 Module"
HOMEPAGE="http://www.dlitz.net/software/python-pbkdf2/"
SRC_URI="mirror://pypi/p/pbkdf2/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE=""

python_test() {
	"${PYTHON}" -m unittest discover "${S}"/test/ || die "Tests failed with ${EPYTHON}"
}