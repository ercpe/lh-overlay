# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit toolchain-funcs eutils

MY_P="RasMol_${PV}"

DESCRIPTION="Free program that displays molecular structure."
HOMEPAGE="http://www.openrasmol.org/"
SRC_URI="http://www.rasmol.org/software/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk"

RDEPEND="x11-libs/libXext
	x11-libs/libXi
	sci-libs/cbflib
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xextproto
	app-text/rman
	x11-misc/imake"

S="${WORKDIR}/${MY_P}_10Apr08"

src_unpack() {
	unpack ${A}
	cd "${S}"

	## We have it in ${DEPEND}.
	## The makefile wants to download it and build it.
	epatch "${FILESDIR}"/cbflib.patch
}

src_compile() {

	cd src

	if use gtk; then
		myconf="${myconf} -DGTKWIN"

		xmkmf ${myconf}|| die "xmkmf failed with ${myconf}"
		make clean
		emake DEPTHDEF=-DTHIRTYTWOBIT CC="$(tc-getCC)" \
	                CDEBUGFLAGS="${CFLAGS}" \
	                || die "32-bit make failed"
	        mv rasmol rasmol.32
	else
		xmkmf || die "xmkmf failed with ${myconf}"
		make clean
		emake DEPTHDEF=-DEIGHTBIT CC="$(tc-getCC)" \
			CDEBUGFLAGS="${CFLAGS}" \
			|| die "8-bit make failed"
		mv rasmol rasmol.8
		emake clean
		emake DEPTHDEF=-DSIXTEENBIT CC="$(tc-getCC)" \
			CDEBUGFLAGS="${CFLAGS}" \
			|| die "16-bit make failed"
		mv rasmol rasmol.16
		make clean
		emake DEPTHDEF=-DTHIRTYTWOBIT CC="$(tc-getCC)" \
			CDEBUGFLAGS="${CFLAGS}" \
			|| die "32-bit make failed"
		mv rasmol rasmol.32
	fi
}

src_install () {
	local libdr=$(get_libdir)
	newbin "${FILESDIR}"/rasmol.sh.debian rasmol
	insinto /usr/${libdir}/${PN}
	doins doc/rasmol.hlp
	exeinto /usr/${libdir}/${PN}
	doexe src/rasmol.{8,16,32}
	dodoc INSTALL PROJECTS README TODO doc/*.{ps,pdf}.gz doc/rasmol.txt.gz
	doman doc/rasmol.1
	insinto /usr/${libdir}/${PN}/databases
	doins data/*
	dohtml *html html_graphics
}
