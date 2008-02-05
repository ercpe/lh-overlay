# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT=""
LICENSE="GPLv2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="A cairo-dock plugin"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/cairo-dock-plugins/${P}.tar.bz2"
HOMEPAGE="http://www.cairo-dock.org/"
IUSE=""
RESTRICT="mirror"

RDEPEND="${DEPEND}"
DEPEND="app-misc/cairo-dock"

## x11-misc/xcompmgr-1.1.3-r1
src_unpack(){
    unpack ${A}
    cd "${S}"
}

src_compile() {
	econf || die "configure failed!"
	
	emake || die "Make failed!"
}

src_install(){
	emake DESTDIR="${D}" install || die "Install failed"
}
