# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit fortran toolchain-funcs

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86"
DESCRIPTION="The REFMAC program can carry out rigid body, tls, restrained or unrestrained refinement against Xray data, or idealisation of a macromolecular structure"
SRC_URI="http://www.ysbl.york.ac.uk/~garib/refmac/data/refmac5.4_source.tar.gz
		 http://www.ysbl.york.ac.uk/~garib/refmac/data/refmac5.4_dictionary.tar.gz"
HOMEPAGE="http://www.ysbl.york.ac.uk/~garib/refmac/index.html"
IUSE="static"
RESTRICT="mirror"

FORTRAN="gfortran ifc"

src_unpack(){
	mkdir ${P}
	cd ${P}
	unpack ${A}
}
#RDEPEND="${RDEPEND}"
DEPEND="sci-chemistry/ccp4"

src_compile(){

	if [[ ${FORTRANC} == gfortran ]];then
		cp makefile_gfortran makefile
		sed -e "s:VERSION = _gfortran:VERSION = _${PV}:"\
			-e "s:FOPTIM  = -O3:FOPTIM  = ${FFLAGS}:"\
			-e "s:LLIBOTHERS = .*$:LLIBOTHERS  =  -lgfortran -lgfortranbegin -lstdc++:"\
			-e "s:  -static-libgcc::"\
			-e "s:/sw/lib/gcc4.2/lib/libgfortran.a::"\
			-i makefile ||die "makefile"
		
	elif [[ ${FORTRANC} == ifort ]];then
		cp makefile_linintel makefile
		sed -e "s:VERSION = _gfortran:VERSION = _${PV}:"\
			-e "s:FOPTIM  =:FOPTIM  = ${FFLAGS}:"\
			-i makefile ||die "makefile"
	fi
	
	if use static;then
		sed -i "s:XFFLAGS =:XFFLAGS = -static:" makefile ||die "static"
	fi
	
	CLIB="/usr/lib" emake V=1 -j1
}
src_install(){
	exeinto /usr/lib/refmac/
	doexe {refmac,makecif,libcheck}_${PV} || die
	dosym /usr/lib/refmac/refmac_${PV} /usr/bin/refmac5
	dosym /usr/lib/refmac/libcheck_${PV} /usr/bin/libcheck
	dosym /usr/lib/refmac/makecif_${PV} /usr/bin/makecif
	
	insinto /usr/share/ccp4/data/monomers
	doins -r dic/*
}