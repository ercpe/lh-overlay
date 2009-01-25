# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

DESCRIPTION="Command line utility able to create bootable USB disks"
HOMEPAGE="http://advancemame.sourceforge.net/boot-readme.html"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="sys-boot/syslinux"
DEPEND="${RDEPEND}"


src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	insinto /usr/share/makebootfat
	doins mbrfat.bin

	cd doc
	dodoc authors.txt history.txt makebootfat.txt readme.txt \
		|| die "dodoc failed"
	dohtml authors.html history.html makebootfat.html readme.html \
		|| die "dohtml failed"
}

