# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN#usf-}"
MY_SERVER="ftp://xray.bmc.uu.se/pub/gerard/${MY_PN}"

HOMEPAGE="http://alpha2.bmc.uu.se/usf/xutil.html"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
SRC_URI="
	${MY_SERVER}/${MY_PN}_linux.tar.gz
	${MY_SERVER}/${MY_PN}_etc.tar.gz
	${MY_SERVER}/${MY_PN}_100_jul08.lib.gz
	${MY_SERVER}/${MY_PN}_25_jul08.lib.gz"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="mirror"
QA_PRESTRIPPED="/opt/usf-dejavu/o2d
	/opt/usf-dejavu/lsqman
	/opt/usf-dejavu/getsse
	/opt/usf-dejavu/dejavu
	/opt/usf-dejavu/dejana"

src_install(){
	exeinto /opt/${PN}
	doexe ${MY_PN}_etc/make_sse || die

	for i in ${MY_PN}_linux/*
	do
		newexe ${i} ${i#${MY_PN}_linux/lx_} || die
	done

	insinto /opt/usf-lib
	doins *.lib ${MY_PN}_etc/*.lib|| die
	dodoc ${MY_PN}_etc/*.doc || die

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/"
	GKLIB="/opt/usf-lib/"
	EOF
	doenvd "${T}"/20${PN}
}
