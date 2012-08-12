# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="control-software for aqua-computer aquaero 4.00"
HOMEPAGE="http://breakbe.at/development/aquaero/"
SRC_URI="http://breakbe.at/development/aquaero/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/libusb:0"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

S="${WORKDIR}/${P}"-src

src_prepare(){
	epatch \
		"${FILESDIR}"/${P}-gcc-4.7.patch \
		"${FILESDIR}"/${P}-makefile.patch
	tc-export CXX
}

src_install(){
	dobin aeinfo aquaerod
	dohtml -r htdocs/*
	dodoc TODO README*
}
