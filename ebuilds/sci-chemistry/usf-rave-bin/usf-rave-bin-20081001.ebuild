# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit private

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
#SRC_URI="ftp://xray.bmc.uu.se/pub/gerard/rave/rave_linux.tar.gz
#		 ftp://xray.bmc.uu.se/pub/gerard/rave/rave_doc.tar.gz"
SRC_URI="${PKG_SERVER}/rave_linux-${PV}.tar.gz
	 ${PKG_SERVER}/rave_doc-${PV}.tar.gz"
HOMEPAGE="http://alpha2.bmc.uu.se/usf/rave.html"
IUSE=""
RESTRICT="mirror"

src_install(){
	exeinto /opt/${PN}
	for i in $(ls rave_linux)
	do
		newexe rave_linux/$i ${i#lx_}
	done
	insinto /usr/share/${PN}
	doins rave_doc/*pdb
	dodoc rave_doc/*{csh,doc}

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/"
	EOF
	doenvd "${T}"/20${PN}
}
