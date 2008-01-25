# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT=""
LICENSE="licened"
KEYWORDS="x86"
DESCRIPTION="Automated crystallographic structure solution for MIR, SAD, and MAD"
SRC_URI="http://solve.lanl.gov/pub/solve/2.13/solve-2.13-linux.tar.gz"
HOMEPAGE="http://www.solve.lanl.gov/index.html"
IUSE=""
RESTRICT="mirror"

src_install(){
	exeinto /opt/xray/solve-resolve/bin/
	doexe solve-2.13/bin/*
	cd solve-2.13/bin/
	for i in `ls resolve* solve*`
		do
			dosym /opt/xray/solve-resolve/bin/$i /usr/bin/$i
		done
	cd ../..
	exeinto /opt/xray/solve-resolve/lib/
	doexe solve-2.13/lib/{*sym,sym*,hist*,*dat}
	exeinto /opt/xray/solve-resolve/lib/segments
	doexe solve-2.13/lib/segments/*
	exeinto /opt/xray/solve-resolve/lib/patterns
	doexe solve-2.13/lib/patterns/*
	
	dohtml -r solve-2.13/lib/html/*
	insinto /usr/share/doc/${PF}/examples_resolve
	doins solve-2.13/lib/examples_resolve/*
	insinto /usr/share/doc/${PF}/examples_solve
	doins -r solve-2.13/lib/examples_solve/*


cat >> "${T}"/20solve-resolve << EOF
CCP4_OPEN="UNKNOWN"
SYMOP="/opt/xray/solve-resolve/lib/symop.lib"
SYMINFO="/opt/xray/solve-resolve/lib/syminfo.lib"
SOLVEDIR="/opt/xray/solve-resolve/lib/"
EOF
	
	doenvd "${T}"/20solve-resolve
}
