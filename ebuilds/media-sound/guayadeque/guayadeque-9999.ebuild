# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: media-sound/guayadeque/guayadeque-9999.ebuild 2009/06/10 01:05:00 lukyn Exp $

EAPI="3"

WX_GTK_VER="2.8"

inherit cmake-utils wxwidgets subversion

DESCRIPTION="Music management program designed for all music enthusiasts"
HOMEPAGE="http://guayadeque.org"
ESVN_REPO_URI="https://guayadeque.svn.sourceforge.net/svnroot/guayadeque/Trunk"
ESVN_PROJECT="guayadeque-svn"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="indicate ipod"

# No test available, Making src_test fail
RESTRICT="test"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	media-libs/flac
	media-libs/gstreamer
	media-libs/taglib
	net-misc/curl
	sys-apps/dbus
	x11-libs/wxGTK:2.8[X,gstreamer]
	indicate? (	dev-libs/libindicate )
	ipod? ( media-libs/libgpod )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/cmake"

# echo $(cat po/CMakeLists.txt | grep ADD_SUBDIRECTORY | sed 's#ADD_SUBDIRECTORY( \(\w\+\) )#\1#')
LANGS="es uk it de fr is nb th cs ru hu sv nl"
for l in ${LANGS}; do
	IUSE="$IUSE linguas_${l}"
done

src_prepare() {
	for l in ${LANGS} ; do
		if ! use linguas_${l} ; then
			sed \
				-e "/${l}/d" \
				-i po/CMakeLists.txt || die
		fi
	done

	if ! use ipod; then
		sed \
			-e '/PKG_CHECK_MODULES( LIBGPOD/,/^ENDIF/d' \
			-i CMakeLists.txt || die
	fi

	if ! use indicate; then
		sed \
			-e '/PKG_CHECK_MODULES( LIBINDICATE/,/^ENDIF/d' \
			-i CMakeLists.txt || die
	fi

	base_src_prepare
}
