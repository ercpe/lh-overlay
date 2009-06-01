# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-4.0_pre20090324.ebuild,v 1.1 2009/03/25 18:09:20 zmedico Exp $

inherit toolchain-funcs

MY_PV=${PV}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:-O2:$(CFLAGS):' \
		-e 's:$(CC):$(CC) $(LDFLAGS):' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	# cvs snapshot only contains README
	# dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README
	dodoc README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.24 kernel or better."
}
