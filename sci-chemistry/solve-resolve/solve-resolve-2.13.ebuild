# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT=""
LICENSE=""
KEYWORDS=""
DESCRIPTION="Automated crystallographic structure solution for MIR, SAD, and MAD"
SRC_URI="http://solve.lanl.gov/pub/solve/2.13/solve-2.13-linux.tar.gz"
HOMEPAGE="http://www.solve.lanl.gov/index.html"
IUSE=""
RESTRICT="primaryuri"

#pkg_nofetch(){
#	if [[ ! -f ${DISTDIR}/solve2.access ]]; then
#		echo ${FETCHCOMMAND}
#		einfo 'Please pay the license fee and place the "solve2.access" in ${DISTDIR}'
#		einfo 'More info for Licening under'
#		einfo 'http://www.solve.lanl.gov/license.html'
#		die
#	fi
#	${FETCHCOMMAND} http://solve.lanl.gov/pub/solve/2.13/solve-2.13-linux.tar.gz
#}

src_install(){
	exeinto /usr/lib/solve-resolve/bin/
	doexe solve-2.13/bin/*
	dosym /usr/lib/solve-resolve/bin/
	exeinto /usr/lib/solve-resolve/lib/
	doexe solve-2.13/lib/*
	
}