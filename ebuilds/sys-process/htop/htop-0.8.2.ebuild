# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/htop/htop-0.8.1-r1.ebuild,v 1.10 2009/03/15 20:20:51 armin76 Exp $

EAPI="2"

inherit eutils flag-o-matic

IUSE="debug unicode"
DESCRIPTION="interactive process viewer"
HOMEPAGE="http://htop.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="sys-libs/ncurses[unicode?]"

pkg_setup() {
	if use elibc_FreeBSD && ! [[ -f "${ROOT}"/proc/stat && -f "${ROOT}"/proc/meminfo ]] ; then
		eerror
		eerror "htop needs /proc mounted to compile and work, to mount it type"
		eerror "mount -t linprocfs none /proc"
		eerror "or uncomment the example in /etc/fstab"
		eerror
		die "htop needs /proc mounted"
	fi
}

src_configure() {
	useq debug && append-flags -O -ggdb -DDEBUG
	econf \
		--enable-taskstats \
		$(use_enable unicode) \
		|| die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog TODO || die
}
