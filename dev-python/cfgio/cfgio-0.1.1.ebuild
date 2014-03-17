# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_3 )

inherit distutils-r1

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://github.com/ercpe/cfgio"
SRC_URI="https://github.com/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test || die "Testing failed with ${EPYTHON}"
}
