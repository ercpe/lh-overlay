# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit private

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="-* ~x86 ~amd64"
DESCRIPTION="The tools package from USF for macromolecular crystallography"
#SRC_URI="ftp://xray.bmc.uu.se/pub/gerard/voidoo/voidoo_linux.tar.gz
#		 ftp://xray.bmc.uu.se/pub/gerard/voidoo/voidoo_etc.tar.gz"
SRC_URI="${PKG_SERVER}/voidoo_linux-${PV}.tar.gz
	 ${PKG_SERVER}/voidoo_etc-${PV}.tar.gz"
HOMEPAGE="http://alpha2.bmc.uu.se/usf/voidoo.html"
IUSE=""
RESTRICT="mirror"

src_install(){
	exeinto /opt/${PN}
	for i in $(ls voidoo_linux)
	do
		newexe voidoo_linux/$i ${i#lx_}
	done
	insinto /opt/usf-lib/
	doins voidoo_etc/*{lib,radii,charges,polar,atypes}
	dodoc voidoo_etc/*doc

	cat>>"${T}"/20${PN}<<-EOF
	PATH="/opt/${PN}/"
	GKLIB="/opt/usf-lib/"
	EOF
	doenvd "${T}"/20${PN}
}
