# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils eutils

DESCRIPTION="Pysize is a graphical and console tool for exploring the size of directories"
HOMEPAGE="http://guichaz.free.fr/pysize/"
SRC_URI="http://guichaz.free.fr/pysize/files/${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gtk ncurses"
RDEPEND="gtk? ( x11-libs/gtk+:2 )
	 ncurses? ( sys-libs/ncurses )
	 psyco? ( dev-python/psyco )"
DEPEND="${RDEPEND}"

src_prepare() {
	if ! use gtk; then
		sed -e '/^from pysize.ui.gtk/d' \
		    -e "s~'gtk': ui_gtk.run,~~g" \
		    -e 's:ui_gtk.run,::g' \
		    -i "${S}"/pysize/main.py || die
		rm -rf "${S}"/pysize/ui/gtk || die
	fi

	if ! use ncurses; then
		sed -e '/^from pysize.ui.curses/d' \
		    -e "s~'curses': ui_curses.run,~~g" \
		    -e 's:ui_curses.run,::g' \
		    -i "${S}"/pysize/main.py || die
		rm -rf "${S}"/pysize/ui/curses || die
	fi

}


src_install() {
	distutils_src_install

	dobin bin/${PN} || die
}
