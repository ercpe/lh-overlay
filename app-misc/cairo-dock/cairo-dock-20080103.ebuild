# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Cairo-dock was in the beginning a small simple but effective dock."
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/cairo-dock/${P}.tar.bz2"
HOMEPAGE="http://www.cairo-dock.org/"
IUSE=""
RESTRICT="mirror"

RDEPEND="media-libs/glitz >x11-libs/gtk+-2.0 gnome-base/librsvg x11-libs/cairo"
DEPEND="${RDEPEND}"

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
