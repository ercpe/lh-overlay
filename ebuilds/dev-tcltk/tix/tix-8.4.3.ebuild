# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tix/tix-8.4.2-r1.ebuild,v 1.4 2008/04/27 20:09:05 maekke Exp $

inherit eutils multilib

MY_P="Tix${PV}"
DESCRIPTION="A widget library for Tcl/Tk. Has been ported to Python and Perl, too."
HOMEPAGE="http://tix.sourceforge.net/"
SRC_URI="mirror://sourceforge/tix/${MY_P}-src.tar.gz"

IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/tk-8.4
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die

	# Bug 168897
	insinto /usr/include; doins generic/tix.h
	# Bug 201138
	dosym ${MY_P}/lib${MY_P}.so /usr/$(get_libdir)/lib${MY_P}.so || die

	dodoc ChangeLog README.txt docs/*.txt
	dohtml -r index.html ABOUT.html docs/
}
