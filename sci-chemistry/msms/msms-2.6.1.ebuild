inherit eutils

DESCRIPTION="This allows you to run msms as a standalone application. A wrapped version of the library comes with MGLTools"
SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/REL2.6.1/msms_i86Linux2_2.6.1.tar.gz"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="academical free"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/lib/msms/
	doins atmtypenumbers
	exeinto /usr/lib/msms/
	doexe pdb_to_xyzr pdb_to_yzrn msms.i86Linux2.2.6.1
	dosym /usr/lib/msms/pdb_to_xyzr /bin/pdb_to_xyzr
	dosym /usr/lib/msms/pdb_to_xyzrn /bin/pdb_to_xyzrn
	dosym /usr/lib/msms/msms.i86Linux2.2.6.1 /usr/bin/msms
	dodoc README ReleaseNotes
	doman msms.1
}

