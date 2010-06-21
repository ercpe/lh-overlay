# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-info toolchain-funcs

DESCRIPTION="Cache remote filesystems locally"
HOMEPAGE="http://people.redhat.com/~dhowells/fscache/"
SRC_URI="http://people.redhat.com/~dhowells/fscache/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-apps/attr"

CONFIG_CHECK="~FSCACHE ~CACHEFILES"

pkg_setup()
{
	if kernel_is lt 2 6 30 ; then
		ewarn "Kernel 2.6.30 or newer is needed to use ${PN}"
	fi
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README howto.txt || die "dodoc failed"
	newinitd "${FILESDIR}"/cachefilesd.rc cachefilesd || die "newinitd failed"
	keepdir /var/fscache || die "keepdir failed"
}
