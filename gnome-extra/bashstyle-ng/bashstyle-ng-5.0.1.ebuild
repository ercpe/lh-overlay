# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A Graphical Tool for styling the BASH"
HOMEPAGE="http://www.gnomefiles.org/app.php/BashStyle-NG"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/gnome-extra/bashstyle-ng/${P}.tar.bz2"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="primaryuri"

RDEPEND="gnome-base/gnome-light"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
    if [ -x ./configure ]; then
        econf
    fi
    if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
        emake || die "emake failed"
    fi
}

src_install() {
    emake DESTDIR="${D}" install || die "Install failed"
    dodoc README CHANGES
}

