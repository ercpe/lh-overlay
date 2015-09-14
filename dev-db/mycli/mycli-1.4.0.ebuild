# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="A Terminal Client for MySQL with AutoCompletion and Syntax Highlighting"
HOMEPAGE="https://github.com/dbcli/mycli"
SRC_URI="https://github.com/dbcli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/click-4.1[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
		=dev-python/prompt_toolkit-0.46[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.6.6[${PYTHON_USEDEP}]
		>=dev-python/python-sqlparse-0.1.16[${PYTHON_USEDEP}]
		>=dev-python/configobj-5.0.6[${PYTHON_USEDEP}]"
