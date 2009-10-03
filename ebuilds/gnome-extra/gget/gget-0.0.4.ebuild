# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit gnome2

DESCRIPTION="A DownLoad Manager for GNOME"
HOMEPAGE="http://live.gnome.org/GGet"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="epiphany"

RDEPEND="
	>=dev-lang/python-2.5
	>=dev-python/dbus-python-0.82
	>=dev-python/gnome-python-2.16
	>=dev-python/gnome-python-extras-2.14.2
	>=dev-python/notify-python-0.1.1
	>=dev-python/pygtk-2.10
	>=dev-python/pygobject-2.12
	gnome-base/gconf:2
	>=x11-libs/gtk+-2.10
	epiphany? ( www-client/epiphany )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable epiphany epiphany-extension) \
		$(use_enable epiphany epiphany-extension-install)
}

src_install() {
	gnome_src_install
	dosed 's:#!/usr/bin/env python2.5:/usr/bin/python:g' /usr/bin/gget || die
}
