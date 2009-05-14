# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN#usf-}"
MY_SERVER="ftp://xray.bmc.uu.se/pub/gerard/${MY_PN}"

HOMEPAGE="http://alpha2.bmc.uu.se/usf/voidoo.html"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
SRC_URI="
	${MY_SERVER}/${MY_PN}_linux.tar.gz
	${MY_SERVER}/${MY_PN}_etc.tar.gz"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="mirror"
QA_PRESTRIPPED="/opt/usf-voidoo/voidoo
	/opt/usf-voidoo/maprop
	/opt/usf-voidoo/flood"

src_install(){
	exeinto /opt/${PN}

	for i in ${MY_PN}_linux/*
	do
		newexe ${i} ${i#${MY_PN}_linux/lx_} || die
	done

	insinto /opt/usf-lib
	doins ${MY_PN}_etc/*.{lib,radii,charges,polar,atypes} || die
	dodoc ${MY_PN}_etc/*.doc || die

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/"
	GKLIB="/opt/usf-lib/"
	EOF
	doenvd "${T}"/20${PN}
}
