# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2 versionator

DESCRIPTION="Alarm Clock is a fully-featured alarm clock for your GNOME panel."
HOMEPAGE="http://alarm-clock.pseudoberries.com/"
SRC_URI="http://launchpad.net/alarm-clock/trunk/$(get_version_component_range 1-2)/+download/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.13
	>=x11-libs/gtk+-2.11.0
	>=gnome-base/gnome-panel-2
	>=gnome-base/gnome-vfs-2.15.4
	>=gnome-base/gconf-2.8.0
	>=gnome-base/libgnome-2.8
	>=gnome-base/libgnomeui-2.8
	>=x11-themes/gnome-icon-theme-2.15
	>=gnome-base/libglade-2.4.0
	>=media-libs/gstreamer-0.10.2
	>=x11-libs/libnotify-0.3.2
"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=app-text/gnome-doc-utils-0.3.2
	dev-util/intltool"
