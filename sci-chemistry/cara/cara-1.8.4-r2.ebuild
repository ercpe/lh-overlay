inherit eutils

DESCRIPTION="CARA is the application for the analysis of NMR spectra and computer aided resonance assignment developed at and used by Prof. Kurt Wuethrich's group"
SRC_URI="http://www.cara.nmr-software.org/downloads/cara_1.8.4_linux.gz
		 ftp://ftp.mol.biol.ethz.ch/software/cara/Start1.2.cara"
HOMEPAGE="www.nmr.ch"
RESTRICT="primaryuri"
LICENSE="free, as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack(){
	unpack cara_1.8.4_linux.gz
	cp ${DISTDIR}/Start1.2.cara ${WORKDIR}
}

src_install() {
	exeinto "/usr/lib/"
	exeopts -m0775
	doexe *
	dosym /usr/lib/cara_1.8.4_linux /usr/bin/cara
	insinto /usr/share/cara/
	doins Start1.2.cara
}

