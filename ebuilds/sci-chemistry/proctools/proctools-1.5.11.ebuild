# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

MY_PV=${PV%.*}

DESCRIPTION="ProcTool - Process, Manage and Sort NMR experiments"
HOMEPAGE="http://proteins.dyndns.org/Software/ProcTool/Help/tutorial.html"
SRC_URI="http://proteins.dyndns.org/Software/ProcTool/procTool1.5.1.11Dec2003.tar"

LICENSE="as-is"

SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND="sci-chemistry/nmrpipe
	 dev-lang/tk
	 app-shells/tcsh"

DEPEND="${RDEPEND}"

S="${WORKDIR}/TOOLS"


src_compile(){
	einfo "It is binary distributed"
}


src_install(){

	make all && \
	make linux || \
	die

	rm "${S}"/bin/{tools.com~,p2x.sgi}
	rm "${S}"/PROCTOOL_${MY_PV}/sort_fids.sgi

	insinto /opt/proctools
	doins -r {Icons,TCL,PROCTOOL_${MY_PV}}
	fperms 755 /opt/proctools/PROCTOOL_${MY_PV}/{nmrManage1.5.1,procTool1.5.1,samples1.5.1,show_procpar,showProt,sort_fids.linux} || \
	die

	exeinto /opt/proctools/bin
	doexe bin/*

	cat >> ${T}/45proctools <<- EOF
	PATH="/opt/proctools/bin"
	EOF

	doenvd ${T}/45proctools

}

