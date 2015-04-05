# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="6550-Jimmac.tar.gz"

DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://jimmac.musichall.cz/i.php3?ikony=71"
SRC_URI="http://kde-look.org/CONTENT/content-files/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/Jimmac

RESTRICT="mirror"

src_install() {
	#X11_IMPLEM_P="$(best_version virtual/x11)"
	#X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	#X11_IMPLEM="${X11_IMPLEM##*\/}"
	X11_IMPLEM="xorg-x11"
	einfo "X11 implementation is ${X11_IMPLEM}."

	insinto /usr/share/cursors/${X11_IMPLEM}/Jimmac/
	doins -r jimmac/cursors
	dodoc README
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: Jimmac"
	echo ""
	einfo "Also, you can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	echo ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "	  /etc/env.d/99xcursors"
	einfo "and change add the line:"
	einfo "	  XCURSORS_THEME="Jimmac""
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	echo ""
	einfo "If you experience flickering, try setting the following line in"
	einfo "the Device section of your XF86Config:"
	einfo "Option \"HWCursor\" \"false\""
}
