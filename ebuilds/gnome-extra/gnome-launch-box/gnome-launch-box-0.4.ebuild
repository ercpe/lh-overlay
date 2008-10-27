# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit gnome2

DESCRIPTION="Application launcher for GNOME."
HOMEPAGE="http://developer.imendio.com/projects/gnome-launch-box"
SRC_URI="http://ftp.imendio.com/pub/imendio/${PN}/src/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/gnome-vfs-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/gnome-menus-2.10
	>=gnome-base/gnome-desktop-2.10
	>=gnome-extra/evolution-data-server-1.8
	>=gnome-base/gconf-2"

RDEPEND="${DEPEND}
	  sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	gnome2_src_unpack

	# Fix tests
	echo "data/90-gnome-launch-box.xml.in" >> po/POTFILES.in
	echo "src/lb-main.c" >> po/POTFILES.in
}
