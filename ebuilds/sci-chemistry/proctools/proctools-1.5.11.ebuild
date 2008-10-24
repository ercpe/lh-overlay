# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# inherit

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
	rm "${S}"/PROCTOOL_1.5/sort_fids.sgi

	
}

