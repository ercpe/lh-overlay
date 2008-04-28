# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs eutils

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="The new Mosflm GUI"
SRC_URI="http://www.mrc-lmb.cam.ac.uk/harry/${PN}/downloads/${PN}.tar.gz"
HOMEPAGE="http://www.mrc-lmb.cam.ac.uk/harry/${PN}/"
IUSE=""
RESTRICT="mirror"
RDEPEND=">=dev-tcltk/itcl-3.3
		 >=dev-tcltk/itk-3.3
		 >=dev-tcltk/iwidgets-4
		 >=dev-tcltk/tkimg-1.3
		 >=dev-tcltk/tdom-0.8
		 >=dev-tcltk/tktreectrl-2.1
		 >=sci-chemistry/mosflm-7.0.3"
DEPEND=""


S="${WORKDIR}"/${PN}

src_unpack(){
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-path.patch
}

src_compile(){
	cd c
	$(tc-getCC) ${CFLAGS} -fPIC -shared -DUSE_TCL_STUBS -DTK_USE_STUBS tkImageLoadDLL.c tkImageLoad.c \
				-o tkImageLoad.so -ltclstub -ltclstub
}

src_install(){
	insinto /usr/$(get_libdir)/${PN}
	doins -r "${S}"/{lib,src,bitmaps}
	fperms 775 /usr/$(get_libdir)/${PN}/src/imosflm
	insinto /usr/$(get_libdir)/${PN}/lib/
	doins "${S}"/c/tkImageLoad.so

	cat >> "${T}"/imoslfm <<- EOF
	#!/bin/sh
	export MOSFLM_WISH="/usr/bin/wish8.4"

	cd /usr/$(get_libdir)/${PN}/src/
	exec ./imosflm
	EOF

	exeinto /usr/bin
	doexe "${T}"/imoslfm
}+