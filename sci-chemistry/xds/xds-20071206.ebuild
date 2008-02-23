# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="X-ray Detector Software for processing single-crystal monochromatic diffraction data recorded by the rotation method."
SRC_URI="ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-linux_ifc_Intel+AMD.tar.gz
		 ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS_html_doc.tar.gz"
HOMEPAGE="http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/"
RESTRICT="mirror"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE="smp X"
RDEPEND="X? ( x11-libs/libXdmcp
			  x11-libs/libXau
			  x11-libs/libX11 )"


src_install() {
	exeinto /opt/XDS
	doexe XDS-linux_ifc_Intel+AMD/*
	if use smp
	then
		rm ${D}/opt/XDS/{xds,mintegrate,mcolspot,xscale}
		dosym /opt/XDS/xds_par /opt/XDS/xds
		dosym /opt/XDS/xscale_par /opt/XDS/xscale
		dosym /opt/XDS/mintegrate_par /opt/XDS/mintegrate
		dosym /opt/XDS/mcolspot_par /opt/XDS/mcolspot
	fi
	if ! use X; then
		rm ${D}/opt/XDS/VIEW
	fi
	dohtml -r XDS_html_doc/*
	dodoc XDS_html_doc/html_doc/INPUT_templates/*
	
	cat>>${T}/20xds<<-EOF
	PATH="/opt/XDS/"
	EOF
	doenvd ${T}/20xds
}

pkg_postinst(){
	einfo "This package will expire at"
	einfo "Expiration date: June 30, 2008"
}

