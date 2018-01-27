# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1

DESCRIPTION="Fuglu plugin to log all mail information via GELF"
HOMEPAGE="https://code.not-your-server.de/fuglu-gelf.git"
SRC_URI="https://git.ercpe.de/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="mail-filter/fuglu[${PYTHON_USEDEP}]
		dev-python/graypy[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}"
