# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/quick-lounge-applet/quick-lounge-applet-2.12.1.ebuild,v 1.5 2007/02/06 13:55:51 blubb Exp $

inherit gnome2

DESCRIPTION="Application launcher applet for GNOME"
HOMEPAGE="http://quick-lounge.sourceforge.net/"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2
	>=gnome-base/gconf-2.0
	>=gnome-base/libgnome-2.4
	>=gnome-base/libgnomeui-2.4
	>=gnome-base/gnome-desktop-2.4
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/libglade-2.4
	>=gnome-base/gnome-panel-2.4
	>=gnome-base/gnome-menus-2.12
	sys-devel/gettext"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"
