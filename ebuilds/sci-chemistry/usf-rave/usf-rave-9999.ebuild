# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="${PN#usf-}"
MY_SERVER="ftp://xray.bmc.uu.se/pub/gerard/${MY_PN}"

HOMEPAGE="http://alpha2.bmc.uu.se/usf/rave.html"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
SRC_URI="
	${MY_SERVER}/${MY_PN}_linux.tar.gz
	${MY_SERVER}/${MY_PN}_doc.tar.gz
	examples? (	${MY_SERVER}/exam.tar.gz )"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
IUSE="examples"

RESTRICT="mirror"

QA_PRESTRIPPED="/opt/usf-rave/bin/ssencs
	/opt/usf-rave/bin/spancsi
	/opt/usf-rave/bin/solex
	/opt/usf-rave/bin/site2rt
	/opt/usf-rave/bin/o2d
	/opt/usf-rave/bin/ncs6d
	/opt/usf-rave/bin/mave
	/opt/usf-rave/bin/maskit
	/opt/usf-rave/bin/mappage
	/opt/usf-rave/bin/mapman
	/opt/usf-rave/bin/mapfix
	/opt/usf-rave/bin/mama
	/opt/usf-rave/bin/imp
	/opt/usf-rave/bin/findncs
	/opt/usf-rave/bin/essens
	/opt/usf-rave/bin/dataman
	/opt/usf-rave/bin/crave
	/opt/usf-rave/bin/comdem
	/opt/usf-rave/bin/comap
	/opt/usf-rave/bin/coma
	/opt/usf-rave/bin/ave"

src_install(){
	exeinto /opt/${PN}/bin
	doexe ${MY_PN}_doc/*.csh || die

	for i in ${MY_PN}_linux/*
	do
		newexe ${i} ${i#${MY_PN}_linux/lx_} || die
	done

	insinto /opt/usf-lib
	doins ${MY_PN}_doc/*.pdb || die
	dodoc ${MY_PN}_doc/*.doc || die

	if use examples; then
		insinto /usr/share/${PN}
		doins -r exam || die
	fi

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/bin"
	GKLIB="/opt/usf-lib/"
	EOF
	doenvd "${T}"/20${PN}
}
