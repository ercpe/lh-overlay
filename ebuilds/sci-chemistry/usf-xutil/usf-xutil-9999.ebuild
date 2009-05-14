# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN#usf-}"
MY_SERVER="ftp://xray.bmc.uu.se/pub/gerard/${MY_PN}"

HOMEPAGE="http://alpha2.bmc.uu.se/usf/xutil.html"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
SRC_URI="
	${MY_SERVER}/${MY_PN}_linux.tar.gz
	${MY_SERVER}/${MY_PN}_etc.tar.gz"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="mirror"
QA_PRESTRIPPED="/opt/usf-xutil/xvrml
	/opt/usf-xutil/xplo2d
	/opt/usf-xutil/xpand
	/opt/usf-xutil/sod
	/opt/usf-xutil/seaman
	/opt/usf-xutil/rmspdb
	/opt/usf-xutil/raxman
	/opt/usf-xutil/pdb2ct
	/opt/usf-xutil/pacman
	/opt/usf-xutil/oops2
	/opt/usf-xutil/oops
	/opt/usf-xutil/odledit
	/opt/usf-xutil/odbman
	/opt/usf-xutil/odbm
	/opt/usf-xutil/o2d
	/opt/usf-xutil/moleman2
	/opt/usf-xutil/moleman
	/opt/usf-xutil/ligcom
	/opt/usf-xutil/hetze
	/opt/usf-xutil/dcup
	/opt/usf-xutil/ct2het
	/opt/usf-xutil/cello
	/opt/usf-xutil/avepdb"

src_install(){
	exeinto /opt/${PN}

	for i in ${MY_PN}_linux/*
	do
		newexe ${i} ${i#${MY_PN}_linux/lx_} || die
	done

	insinto /opt/usf-lib
	doins ${MY_PN}_etc/*.lib|| die
	dodoc ${MY_PN}_etc/*.doc || die

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/"
	GKLIB="/opt/usf-lib/"
	EOF
	doenvd "${T}"/20${PN}
}
