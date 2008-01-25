# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit enlightenment subversion

ESVN_REPO_URI="http://itask-module.googlecode.com/svn/trunk/winlist_ng"
S="${WORKDIR}/winlist_ng"

DESCRIPTION="winlist-ng plugin for e17"
HOMEPAGE="http://code.google.com/p/itask-module"

DEPEND=">=x11-wm/e-0.16.999.039
        media-libs/edje
	dev-libs/efreet"
RDEPEND=${DEPEND}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	eautoreconf || die
	econf || die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed!"
}

warning() {
	ewarn "Please do not contact the E team about bugs in Gentoo."
	ewarn "Only contact vapier@gentoo.org via e-mail or bugzilla."
	ewarn "Remember, this stuff is experimental code so dont cry"
	ewarn "when I break you :)."
}

pkg_setup() {
	warning
}

pkg_postinst() {
	warning
}

