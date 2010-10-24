# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils git multilib

EGIT_REPO_URI="git://github.com/lpereira/hardinfo.git"

DESCRIPTION="System information and benchmark tool"
HOMEPAGE="http://hardinfo.berlios.de/"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="debug"

RDEPEND="
	dev-libs/glib:2
	net-libs/libsoup:2.4
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_prepare() {
	git_src_prepare
	sed "s:lib/:$(get_libdir)/:g" -i config.h.cmake CMakeLists.txt || die
	use debug && CMAKE_BUILD_TYPE="Debug"
}
