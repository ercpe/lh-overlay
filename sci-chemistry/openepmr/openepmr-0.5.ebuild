# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="A new, open-source version of the molecular replacement program"
SRC_URI="http://homepage.mac.com/WebObjects/FileSharing.woa/wa/epmr0.5-src.tar.gz.5-src.tar.gz?a=downloadFile&user=crkissinger&path=.Public/EPMR%20Distribution/Version%200.5/epmr0.5-src.tar.gz
		 doc? ( http://homepage.mac.com/WebObjects/FileSharing.woa/wa/epmr-user-guide.pdf.pdf-zip.zip?a=downloadFile&user=crkissinger&path=.Public/EPMR%20Distribution/Version%200.5/epmr-user-guide.pdf )"
HOMEPAGE="http://www.epmr.info/"
IUSE="doc"

RESTRICT="mirror"

src_compile(){
	einfo "The author claims -O3 -ffast-math -finline-limit=1200 -ftree-vectorize"
	einfo "as best CFLAGS for compilation"
	einfo "compiling with ${CFLAGS}"
	cd epmr0.5/src
	$(tc-getCXX) -o epmr $CFLAGS *.cpp
}
src_install(){
	exeinto /usr/bin
	doexe epmr0.5/src/epmr
	dodoc epmr0.5/src/{README,CHANGES}
	if use doc;then
		insinto /usr/share/doc/${PF}/
		doins ${DISTDIR}/epmr-user-guide.pdf
	fi
}