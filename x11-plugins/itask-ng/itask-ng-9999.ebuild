# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion autotools

ESVN_REPO_URI="http://itask-module.googlecode.com/svn/trunk"
ESVN_PROJECT="itask-module"

DESCRIPTION="itask-ng plugin for e17"
HOMEPAGE="http://code.google.com/p/itask-module"

#S="${WORKDIR}/${PN}"

DEPEND=">=x11-wm/e-0.16.999.039
        media-libs/edje
	dev-libs/efreet"
RDEPEND=${DEPEND}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

src_compile() {
	cd ${PN}
	eautoreconf || die
	econf || die
	emake || die
}

src_install() {
	cd ${PN}
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

