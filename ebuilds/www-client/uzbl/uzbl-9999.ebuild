# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://github.com/Dieterbe/uzbl.git"

inherit git toolchain-funcs

DESCRIPTION="The uzbl browser"
HOMEPAGE="http://www.uzbl.org"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

RDEPEND="
	dev-lang/perl
	gnome-extra/zenity
	net-misc/socat
	>=net-libs/libsoup-2.24
	>=net-libs/webkit-gtk-1.1.4
	>=x11-libs/gtk+-2.14"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig"

EGIT_PATCHES=(
	"${FILESDIR}"/${PV}-Makefile.patch
)

src_compile() {
	emake \
		CC=$(tc-getCC) \
		|| die
}

src_install() {
	dobin ${PN} || die
	dodoc AUTHORS README docs/* || die
}
