# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit apache-module

DESCRIPTION="Apache 2.2.x mod_cache provider module for memcached backed HTTP caching."
HOMEPAGE="http://code.google.com/p/modmemcachecache/"
SRC_URI="http://modmemcachecache.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/apr-util-1.3.9 >=www-servers/apache-2.2 =dev-libs/apr_memcache-0.7.0"

APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="MEMCACHED_CACHE"

DOCFILES="README"

need_apache2

src_configure() {
	export CFLAGS="-I${FILESDIR}"
	econf --with-apxs=${APXS}	
}

src_compile() {
	emake || die "emake failed"
}
