# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-2 multilib

DESCRIPTION="System information and benchmark tool"
HOMEPAGE="http://hardinfo.berlios.de/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/lpereira/hardinfo.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-libs/glib:2
	net-libs/libsoup
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed \
		-e 's/g_build_filename(prefix, "lib"/g_build_filename(prefix, "'$(get_libdir)'"/' \
		-i hardinfo/binreloc.c || die
}
