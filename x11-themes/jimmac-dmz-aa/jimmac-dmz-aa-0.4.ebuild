# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_PN="${PN//jimmac-/}"

DESCRIPTION="A high quality set of Xfree 4.3.0 animated mouse cursors"
HOMEPAGE="http://jimmac.musichall.cz/themes.php?skin=7"
SRC_URI="http://jimmac.musichall.cz/zip/vanilla-${MY_PN}-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

S="${WORKDIR}"/Vanilla-DMZ-AA

src_install() {
	insinto /usr/share/cursors/xorg-x11/${MY_PN}
	doins -r index.theme cursors
}

pkg_postinst() {
	einfo "To use this set of cursors, edit or create the file ~/.Xdefaults"
	einfo "and add the following line:"
	einfo "Xcursor.theme: ${MY_PN}"
	elog ""
	einfo "Also, you can change the size by adding a line like:"
	einfo "Xcursor.size: 48"
	elog ""
	einfo "To globally use this set of mouse cursors edit the file:"
	einfo "	  /etc/env.d/99xcursors"
	einfo "and change add the line:"
	einfo "	  XCURSORS_THEME="${MY_PN}""
	einfo "Note this will be overruled by a user's ~/.Xdefaults file."
	elog ""
	ewarn "If you experience flickering, try setting the following line in"
	ewarn "the Device section of your XF86Config:"
	ewarn "Option \"HWCursor\" \"false\""
}
