# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="The httplib2 caching algorithms packaged up for use with requests"
HOMEPAGE="https://github.com/ionrock/cachecontrol"
SRC_URI="https://github.com/ionrock/cachecontrol/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="redis"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]
	redis? ( dev-python/redis-py[${PYTHON_USEDEP}] )"
