inherit eutils

DESCRIPTION="X-ray Detector Software for processing single-crystal monochromatic diffraction data recorded by the rotation method."
SRC_URI="ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-linux_ifc_Intel+AMD.tar.gz
ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS_html_doc.tar.gz
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-ADSC.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-BRANDEIS_B4.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-CCDBRANDEIS.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-CRYSALIS.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-DIP2020.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-D2AM.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-ESRF.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-MAR.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-MAR345.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-MARCCD.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-PILATUS.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-RAXIS2.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-RAXIS4.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-RAXIS5.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-SATURN.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-SIEMENS.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-SMARTCCD.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-STOE.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDS-VIDEMETRIX.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XSCALE.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/XDSCONV.INP
http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/html_doc/INPUT_templates/CELLPARM.INP"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mp"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack XDS-linux_ifc_Intel+AMD.tar.gz
	unpack XDS_html_doc.tar.gz
}


src_install() {
	dodir "/usr/lib/XDS"
	dodir "/usr/bin/"
	exeinto "/usr/lib/XDS"
	exeopts -m0775
	doexe XDS-linux_ifc_Intel+AMD/*
	dosym /usr/lib/XDS/xdsconv /usr/bin/xdsconv
	if use mp
	then
		dosym /usr/lib/XDS/xds_par /usr/bin/xds
		dosym /usr/lib/XDS/xscale_par /usr/bin/xscale
		dosym /usr/lib/XDS/xds /usr/bin/xds_single
		dosym /usr/lib/XDS/xscale /usr/bin/xscale_single
	else
		dosym /usr/lib/XDS/xds_par /usr/bin/xds_par
		dosym /usr/lib/XDS/xscale_par /usr/bin/xscale_par
		dosym /usr/lib/XDS/xds /usr/bin/xds
		dosym /usr/lib/XDS/xscale /usr/bin/xscale
	fi
	dohtml -r XDS_html_doc/*
	dodoc ../distdir/*INP
}

