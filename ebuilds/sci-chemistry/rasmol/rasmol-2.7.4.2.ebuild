# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

MY_P="RasMol_${PV}"

DESCRIPTION="Free program that displays molecular structure."
HOMEPAGE="http://www.openrasmol.org/"
SRC_URI="http://www.rasmol.org/software/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXext
	x11-libs/libXi
	|| ( x11-apps/xdpyinfo x11-apps/xwininfo )"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	app-text/rman
	x11-misc/imake"

S="${WORKDIR}/${MY_P}_10Apr08"

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#
#	# Hack required for build
#	cd src
#	ln -s ../doc
#}

src_compile() {
	cd src
	xmkmf || die "xmkmf failed"
	make DEPTHDEF=-DEIGHTBIT CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "8-bit make failed"
	mv rasmol rasmol.8
	make clean
	make DEPTHDEF=-DSIXTEENBIT CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "16-bit make failed"
	mv rasmol rasmol.16
	make clean
	make DEPTHDEF=-DTHIRTYTWOBIT CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		|| die "32-bit make failed"
	mv rasmol rasmol.32
	make clean
}

src_install () {
	newbin "${FILESDIR}"/rasmol.sh.debian rasmol
	insinto /usr/lib/${PN}
	doins doc/rasmol.hlp
	exeinto /usr/lib/${PN}
	doexe src/rasmol.{8,16,32}
	dodoc INSTALL PROJECTS README TODO doc/*.{ps,pdf}.gz doc/rasmol.txt.gz
	doman doc/rasmol.1
	insinto /usr/lib/${PN}/databases
	doins data/*
}
