# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit fortran toolchain-funcs

MY_P="${PN}"_"${PV}"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="-* ~x86 ~amd64"
DESCRIPTION="REFMAC can carry out rigid body, tls, restrained or unrestrained refinement against Xray data"
SRC_URI="http://www.ysbl.york.ac.uk/${PN}/data/${PN}_stable/${MY_P}.tar.gz
		 http://www.ysbl.york.ac.uk/${PN}/data/${PN}_dictionary.tar.gz"
HOMEPAGE="http://www.ysbl.york.ac.uk/~garib/refmac/index.html"
IUSE="static"
RESTRICT="mirror"

FORTRAN="gfortran ifc"

src_unpack(){
	mkdir ${P}
	cd ${P}
	unpack ${A}
}
#RDEPEND="${DEPEND}"
DEPEND="sci-chemistry/ccp4
		virtual/blas
		virtual/lapack"

src_compile(){
	if [[ ${FORTRANC} == ifort ]];then
		sed -e "s:FC      = gfortran:FC      = ${FORTRANC}:"\
			-i makefile ||die "makefile"
	fi

	sed -e "s:VERSION = gfortran:VERSION = _${PV}:"\
		-e "s:FC      = gfortran:FC      = ${FORTRANC}:"\
		-e "s:CC      = gcc:CC      = $(tc-getCC):" \
		-e "s:CPP     = g++:CPP     = $(tc-getCPP):" \
		-e "s:FOPTIM  = -O2 -m32 :FOPTIM  = ${FFLAGS}:"\
		-e "s:COPTIM  = -O2 -m32 :COPTIM  = ${CFLAGS}:"\
		-e "s:/lapack::g"\
		-i makefile ||die "makefile_all"

	if ! use static;then
		sed -i "s: -static::" makefile ||die "static"
	fi

#	cat makefile
#	emake clean	
	CLIB="/usr/lib" emake -j1||die
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
