# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git cmake-utils
#inherit git

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://keepassx.sourceforge.net/"
EGIT_REPO_URI="git://gitorious.org/keepassx/keepassx.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug pch"

DEPEND="
	dev-libs/libgcrypt
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4
	|| ( >=x11-libs/libXtst-1.1.0 <x11-proto/xextproto-7.1.0 )"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
}

src_install() {
	insinto /usr
	doins -r share || die
	dobin ${CMAKE_BUILD_DIR}/src/${PN} || die
}
