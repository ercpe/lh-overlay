# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils multilib

DESCRIPTION="This allows you to run msms as a standalone application. A wrapped version of the library comes with MGLTools"
SRC_URI="x86? ( http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/REL${PV}/${PN}_i86Linux2_${PV}.tar.gz )
		 amd64? ( http://mgltools.scripps.edu/downloads/tars/releases/MSMSRELEASE/REL${PV}/${PN}_i86_64Linux2_${PV}.tar.gz )"
HOMEPAGE="http://mgltools.scripps.edu"
RESTRICT="mirror"
LICENSE="academical free"
SLOT=""
KEYWORDS="~x86 ~amd64"
IUSE="static"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/$(get_libdir)/msms/
	doins atmtypenumbers
	exeinto /usr/$(get_libdir)/msms/
	doexe pdb_to_xyzr pdb_to_xyzrn 
	if [[ ${ARCH}=="x86" ]];then
		doexe msms.i86Linux2.2.6.1
		dosym /usr/lib/msms/msms.i86Linux2.2.6.1 /usr/bin/msms
	elif [[ ${ARCH}=="amd64" ]];then
		use !static && doexe msms.x86_64Linux2.2.6.1  && dosym /usr/$(get_libdir)/msms/msms.x86_64Linux2.2.6.1 /usr/bin/msms
		use static && doexe msms.x86_64Linux2.2.6.1.staticgcc && dosym /usr/$(get_libdir)/msms/msms.x86_64Linux2.2.6.1.staticgcc /usr/bin/msms
	else
		die || "${Arch} not supported"
	fi
	dosym /usr/$(get_libdir)/msms/pdb_to_xyzr /usr/bin/pdb_to_xyzr
	dosym /usr/$(get_libdir)/msms/pdb_to_xyzrn /usr/bin/pdb_to_xyzrn
	dodoc README ReleaseNotes
	doman msms.1
}

