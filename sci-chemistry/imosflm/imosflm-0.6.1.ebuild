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

S=${PN}

src_unpack(){
	unpack ${A}
	epatch "${FILESDIR}"/${PV}-path.patch
}

src_compile(){
	cd "${S}"/c
	$(tc-getCC) ${CFLAGS} -fPIC -shared -DUSE_TCL_STUBS -DTK_USE_STUBS tkImageLoadDLL.c tkImageLoad.c \
				-o tkImageLoad.so -ltclstub8.4 -ltclstub8.4
}

src_install(){
	insinto /usr/lib/${PN}
	doins -r "${S}"/{lib,src,bitmaps}
	fperms 775 /usr/lib/${PN}/src/imosflm
	insinto /usr/lib/${PN}/lib/
	doins "${S}"/c/tkImageLoad.so
	dosym ../lib/${PN}/src/imosflm /usr/bin/imosflm
}