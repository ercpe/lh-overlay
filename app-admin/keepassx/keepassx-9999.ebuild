# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-2 virtualx

DESCRIPTION="Qt password manager compatible with its Win32 and Pocket PC versions"
HOMEPAGE="http://www.keepassx.org/"
EGIT_REPO_URI="https://github.com/keepassx/keepassx.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	dev-libs/libgcrypt:0=
	dev-qt/qtcore:4=
	dev-qt/qtdbus:4=
	dev-qt/qtgui:4=
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:4 )"

src_configure() {
	local mycmakeargs=(
		-DWITH_CXX11=ON
		-DWITH_LTO=ON
		$(cmake-utils_use_with test GUI_TESTS)
		$(cmake-utils_use_with test TESTS)
		)
	cmake-utils_src_configure
}

src_test() {
	VIRTUALX_COMMAND="cmake-utils_src_test"
	virtualmake
}
