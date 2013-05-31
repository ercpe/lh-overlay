# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="a client for memcached written in C, using APR and APR-Util"
HOMEPAGE="http://www.outoforder.cc/projects/libs/apr_memcache/"
SRC_URI="http://www.outoforder.cc/downloads/apr_memcache/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/apr
	dev-libs/apr-util"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README NOTICE
}
