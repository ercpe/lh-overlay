# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Plot graphics in an easy and intuitive way"
HOMEPAGE="http://cairoplot.sourceforge.net/ https://github.com/rodrigoaraujo01/cairoplot/"
SRC_URI="https://github.com/rodrigoaraujo01/cairoplot/archive/${PV}.tar.gz -> ${P}.tgz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pycairo[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/cairoplot-${PV}/trunk

python_test() {
	${EPYTHON} tests.py || die
	${EPYTHON} seriestests.py || die
}
