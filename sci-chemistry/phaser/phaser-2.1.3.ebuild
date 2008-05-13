# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Phasing macromolecular crystal structures with maximum likelihood methods"
SRC_URI="ftp://ftp.ccp4.ac.uk/cctbx_based/6.0.2/${P}-cctbx-src.tar.gz"
HOMEPAGE="http://www-structmed.cimr.cam.ac.uk/phaser/"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}""/ccp4-6.0.2"

src_compile(){
	cd src/${PN}
	mkdir "${WORKDIR}/phaser"
	./install --force-compile --compiler=$(tc-getCC)  --prefix="${WORKDIR}/phaser"
}