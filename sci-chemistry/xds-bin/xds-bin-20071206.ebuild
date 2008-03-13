# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="X-ray Detector Software for processing single-crystal monochromatic diffraction data."
SRC_URI="ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS-linux_ifc_Intel+AMD.tar.gz
		 ftp://ftp.mpimf-heidelberg.mpg.de/pub/kabsch/XDS_html_doc.tar.gz"
HOMEPAGE="http://www.mpimf-heidelberg.mpg.de/~kabsch/xds/"
RESTRICT="mirror"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="smp X"
RDEPEND="X? ( x11-libs/libXdmcp
			  x11-libs/libXau
			  x11-libs/libX11 )"
DEPEND=""

src_install() {
	exeinto /opt/xds
	doexe XDS-linux_ifc_Intel+AMD/*
	if use smp
	then
		rm "${D}"/opt/xds/{xds,mintegrate,mcolspot,xscale}
		dosym xds_par /opt/xds/xds
		dosym xscale_par /opt/xds/xscale
		dosym mintegrate_par /opt/xds/mintegrate
		dosym mcolspot_par /opt/xds/mcolspot
	fi
	if ! use X; then
		rm "${D}"/opt/xds/VIEW
	fi
	dohtml -r XDS_html_doc/*
	dodoc XDS_html_doc/html_doc/INPUT_templates/*

	cat>>"${T}"/20xds<<-EOF
	PATH="/opt/xds/"
	EOF
	doenvd "${T}"/20xds
}

pkg_postinst(){
	einfo "This package will expire at"
	einfo "Expiration date: June 30, 2008"
}

