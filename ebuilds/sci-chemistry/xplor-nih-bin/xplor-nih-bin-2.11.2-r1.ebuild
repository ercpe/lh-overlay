# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="\
XPLOR-NIH is a structure determination program which builds on the X-PLOR
program, including additional tools developed at the NIH."
HOMEPAGE="http://nmr.cit.nih.gov/xplor-nih/"
SRC_URI="xplor-nih-${PV}-Linux_2.4_i686.tar.gz"
LICENSE="GPL"
IUSE=""
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"

DEPEND=""

S=${WORKDIR}/${P}/

pkg_nofetch() {
	einfo "Please go to the homepage at http://nmr.cit.nih.gov/xplor-nih/"
	einfo "and download the 2.11.2 package for Linux 2.4 i686."
}

src_compile() {
	cd ${S} || die
	# Do not use econf here, ./configure doesn't take the --prefix=/usr
	# argument.
	./configure || die
}

src_install() {
	cd ${S}/bin || die

	sed -i -e 's/tail -/tail -n /' xplor
	sed -i -e 's/tail -/tail -n /' xplor_mpi
	sed -i -e 's/tail -/tail -n /' seq2psf
	sed -i -e 's/tail -/tail -n /' pyXplor
	sed -i -e 's/tail -/tail -n /' tclXplor
	sed -i -e 's/head -/head -n /' xplor
	sed -i -e 's/head -/head -n /' xplor_mpi
	sed -i -e 's/head -/head -n /' seq2psf
	sed -i -e 's/head -/head -n /' pyXplor
	sed -i -e 's/head -/head -n /' tclXplor

	export NS=`echo ${S} | sed -e 's/\/$//' -e 's/\\//\\\\\//g'`
	sed -i -e "s/${NS}/\/usr\/share\/xplor/" xplor
	sed -i -e "s/${NS}/\/usr\/share\/xplor/" xplor_mpi
	sed -i -e "s/${NS}/\/usr\/share\/xplor/" seq2psf
	sed -i -e "s/${NS}/\/usr\/share\/xplor/" pyXplor
	sed -i -e "s/${NS}/\/usr\/share\/xplor/" tclXplor
	
	dobin tclXplor xplor_mpi xplor seq2psf pdb2psf pyXplor || die

	cd ${S}

	dodir /usr/share/xplor
	cp -rf ${S}/bin ${S}/bin.Linux_2.4_i686 ${S}/arch ${S}/python ${S}/tcl \
		${D}/usr/share/xplor
}


