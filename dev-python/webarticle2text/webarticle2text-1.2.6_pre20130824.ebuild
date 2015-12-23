# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Extracts the main article text from a webpage"
HOMEPAGE="https://github.com/chrisspen/webarticle2text"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/pytidylib[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# installing the same module as a cli binary breaks the python imports
	sed -i -e 's/scripts.*//g' "${S}"/setup.py || die
	distutils-r1_python_prepare_all
}