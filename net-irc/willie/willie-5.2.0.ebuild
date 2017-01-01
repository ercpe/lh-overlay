# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="An easy-to-use and highly extensible IRC Bot framework"
HOMEPAGE="http://willie.dftba.net/"
SRC_URI="https://github.com/embolalia/willie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EFL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pyenchant[${PYTHON_USEDEP}]
		dev-python/geoip-python[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/backports-ssl-match-hostname[${PYTHON_USEDEP}]' python2_7)"
