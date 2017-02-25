# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Client for memcached written in C, using APR and APR-Util"
HOMEPAGE="http://www.outoforder.cc/projects/libs/apr_memcache/"
SRC_URI="http://www.outoforder.cc/downloads/apr_memcache/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/apr
	dev-libs/apr-util"
RDEPEND="${DEPEND}"
