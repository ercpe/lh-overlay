# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python{3_4,3_5} pypy )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="IP subnet calculator"
HOMEPAGE="https://pypi.python.org/pypi/ipcalc/"
SRC_URI="https://github.com/tehmaze/${PN}/archive/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""
