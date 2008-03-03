# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit fortran toolchain-funcs

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86"
DESCRIPTION="The REFMAC program can carry out rigid body, tls, restrained or unrestrained refinement against Xray data, or idealisation of a macromolecular structure"
SRC_URI="http://www.ysbl.york.ac.uk/~garib/refmac/data/refmac_sad_source.tar.gz
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
RDEPEND="${RDEPEND}"
DEPEND="sci-chemistry/ccp4
		virtual/blas
		virtual/lapack"

src_compile(){
	if [[ ${FORTRANC} == gfortran ]];then
		sed -e "s:VERSION = gfortran:VERSION = _${PV}:"\
			-e "s:CC      = gcc:CC      = $(tc-getCC):" \
			-e "s:CPP     = g++:CPP     = $(tc-getCPP):" \
			-e "s:FOPTIM  = -O2 -m32 :FOPTIM  = ${FFLAGS}:"\
			-e "s:COPTIM  = -O2 -m32 :COPTIM  = ${CFLAGS}:"\
			-e "s:/lapack::g"\
			-i makefile ||die "makefile"
		
	elif [[ ${FORTRANC} == ifort ]];then
		sed -e "s:VERSION = gfortran:VERSION = _${PV}:"\
			-e "s:FC      = gfortran:FC      = ${FORTRANC}:"\
			-e "s:CC      = gcc:CC      = $(tc-getCC):" \
			-e "s:CPP     = g++:CPP     = $(tc-getCPP):" \
			-e "s:FOPTIM  = -O2 -m32 :FOPTIM  = ${FFLAGS}:"\
			-e "s:COPTIM  = -O2 -m32 :COPTIM  = ${CFLAGS}:"\
			-e "s:/lapack::g"\
			-i makefile ||die "makefile"
	fi
	
	if ! use static;then
		sed -i "s: -static::" makefile ||die "static"
	fi
	
#	cat makefile
#	emake clean	
	CLIB="/usr/lib" emake -j1||die "compile"
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