# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

MY_PN="geoip-api-python"

DESCRIPTION="MaxMind GeoIP Legacy Python Extension API"
HOMEPAGE="https://github.com/maxmind/geoip-api-python"
SRC_URI="https://github.com/maxmind/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

DEPEND="dev-libs/geoip
	!dev-python/geoip-python
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_PN}-${PV}"

python_test() {
	esetup.py test
}
