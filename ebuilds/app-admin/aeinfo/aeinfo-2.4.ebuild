# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

DESCRIPTION="aeinfo"
HOMEPAGE="http://breakbe.at/development/aquaero/"
SRC_URI="http://breakbe.at/development/aquaero/${P}-src.tar.gz"
LICENSE="LPGL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

S="${WORKDIR}/${P}"-src

src_compile(){
	sed "s:g++ -Wno-deprecated:$(tc-getCXX) ${CFLAGS} -Wno-deprecated:g" \
	-i Makefile

	emake
}