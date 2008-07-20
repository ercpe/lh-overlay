# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit private

DESCRIPTION="Gentoo LiveCD theme for the GDM Greeter"
HOMEPAGE="http://gnome-look.org/content/show.php/Unofficial+Gentoo+2007.1+GDM?content=53701"
SRC_URI="${PKG_SERVER}/${PF}.tar.bz2"

RDEPEND="gnome-base/gdm"
RESTRICT="mirror"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/gdm/themes
	doins -r *
}
