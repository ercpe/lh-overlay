# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 cmake-utils
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

src_install() {
	insinto /usr
	doins -r share
	dobin "${CMAKE_BUILD_DIR}"/src/${PN}
}
