inherit eutils

DESCRIPTION="HKL2MAP is a graphical user-interface for macromolecular phasing."
SRC_URI="${P}.tgz"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri fetch"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND="sci-chemistry/shelx"
DEPEND="${RDEPEND}"

pkg_nofetch(){
        einfo "Please visit:"
        einfo "\thttp://schneider.group.ifom-ieo-campus.it/hkl2map/index.html"
        einfo
        einfo "Complete the registration process, then download the following files:"
        einfo "\t${A}"
        einfo
        einfo "Place the downloaded files in your distfiles directory:"
        einfo "\t${DISTDIR}"
        echo
        einfo "or if you have access to ftp://j-schmitz.net then"
        einfo " do fetch_restricted hkl2map-0.2.tgz"
        echo
}

src_unpack() {
	unpack hkl2map-0.2.tgz
}

src_install() {
	dodir "/usr/bin"
	exeinto "/usr/bin"
	exeopts -m0775
	newexe hkl2map-0.2-dist hkl2map
}

pkg_postinst(){
	echo
	einfo "If you use HKL2MAP in you work, please cite the following publication:"
	echo
	einfo "Thomas Pape & Thomas R. Schneider"
	einfo "HKL2MAP: a graphical user interface for phasing with SHELX programs"
	einfo "J. Appl. Cryst. 37:843-844 (2004)."
	echo
}
