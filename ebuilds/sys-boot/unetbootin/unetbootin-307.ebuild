# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-304-r1.ebuild,v 1.1 2009/01/11 16:01:08 jer Exp $

inherit eutils

DESCRIPTION="Universal Netboot Installer creates Live USB systems for various OS
distributions."
HOMEPAGE="http://unetbootin.sourceforge.net/"
SRC_URI="mirror://sourceforge/unetbootin/${PN}-source-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}"

DEPEND="x11-libs/qt-gui"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-syslinux-gentoo.patch
}

src_compile() {
	./INSTALL || die "compile failed!"
}

src_install() {
	dodoc README.TXT
	dobin unetbootin || die "dobin failed"
}
