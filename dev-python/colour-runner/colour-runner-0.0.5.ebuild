# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Colour formatting for unittest output"
HOMEPAGE="https://github.com/meshy/colour-runner"
SRC_URI="https://github.com/meshy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/blessings[${PYTHON_USEDEP}]
			dev-python/pygments[${PYTHON_USEDEP}]"
