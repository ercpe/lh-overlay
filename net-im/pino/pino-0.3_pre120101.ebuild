# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

REV="eeddbfdb41fa"

DESCRIPTION="Twitter and Identi.ca client"
HOMEPAGE="http://pino-app.appspot.com/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${PN}-${REV}.tar.bz2"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	app-text/gtkspell:2
	dev-libs/glib:2
	>=dev-libs/libgee-0.5
	dev-libs/libindicate
	dev-libs/libunique
	dev-libs/libxml2:2
	net-libs/libsoup:2.4
	net-libs/rest
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12"

S="${WORKDIR}"/troorl-pino3-${REV}/

PATCHES=(
	"${FILESDIR}"/gold.patch
	)

src_prepare() {
	sed '/COPYING/d' -i CMakeLists.txt || die
	base_src_prepare
}

src_configure() {
	mycmakeargs=(
	-DVALA_EXECUTABLE="$(type -P valac-0.12)"
	-DUBUNTU_ICONS=OFF
	$(cmake-utils_use_enable debug DEBUG)
	)
	cmake-utils_src_configure
}