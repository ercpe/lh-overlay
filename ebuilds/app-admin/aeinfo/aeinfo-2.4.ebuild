# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="aeinfo"
HOMEPAGE="http://breakbe.at/development/aquaero/"
SRC_URI="http://breakbe.at/development/aquaero/${P}-src.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"
RDEPEND="dev-libs/libusb"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"-src

src_compile(){
	sed "s:g++ -Wno-deprecated:$(tc-getCXX) ${CFLAGS} -Wno-deprecated:g" \
	-i Makefile

	emake
}

src_install(){
	dobin aeinfo aquaerod
	dohtml -r htdocs/*
	dodoc TODO README*
}

