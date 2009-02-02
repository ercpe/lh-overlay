# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Phasing macromolecular crystal structures with maximum likelihood methods"
SRC_URI="ftp://ftp.ccp4.ac.uk/ccp4/6.1/${P}-cctbx-src.tar.gz"
HOMEPAGE="http://www-structmed.cimr.cam.ac.uk/phaser/"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-util/scons"
RDEPEND=""

S="${WORKDIR}""/ccp4-6.0.2"

src_compile(){

	local NUMJOBS

	NUMJOBS=$(sed -e "s/.*-j\([0-9]\+\).*/\1/") <<< ${MAKEOPTS}

	cd src/${PN}
	mkdir "${WORKDIR}/phaser"
	./install --nproc=${NUMJOB} --force-compile --compiler=$(tc-getCC)  --prefix="${WORKDIR}/phaser" \
		--component="mmtbx" --component="phaser" || die

}
