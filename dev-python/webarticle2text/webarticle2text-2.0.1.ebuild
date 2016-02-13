# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 ) # upstream supports 3.x but pytidylib doesn't

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Extracts the main article text from a webpage"
HOMEPAGE="https://github.com/chrisspen/webarticle2text"
SRC_URI="https://github.com/chrisspen/webarticle2text/archive/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/pytidylib[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
