# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

I="/opt/foldingathome"

inherit eutils

DESCRIPTION="Help simulate protein folding at home"
HOMEPAGE="http://folding.stanford.edu/"
SRC_URI="http://www.stanford.edu/group/pandegroup/release/FAH504-Linux.exe"
RESTRICT="mirror strip"

SLOT="0"
IUSE=""
LICENSE="folding-at-home"
KEYWORDS="~amd64 ~x86"

DEPEND=">=sys-apps/baselayout-1.8.0
		>=sys-libs/glibc-2.3.0
		amd64? ( app-emulation/emul-linux-x86-baselibs )"

S="${WORKDIR}"

src_unpack() {
		cp "${DISTDIR}/${A}" ${PN}
}

src_install() {
	exeinto ${I}
	newexe "${FILESDIR}"/initfolding-r2 initfolding
	newexe "${FILESDIR}"/copy_client_config-${PV}-r1 copy_client_config

	# Clients
	exeinto ${I}/client1
	doexe foldingathome
	exeinto ${I}/client2
	doexe foldingathome
	exeinto ${I}/client3
	doexe foldingathome
	exeinto ${I}/client4
	doexe foldingathome
	exeinto ${I}/client5
	doexe foldingathome
	exeinto ${I}/client6
	doexe foldingathome
	exeinto ${I}/client7
	doexe foldingathome
	exeinto ${I}/client8
	doexe foldingathome
	newinitd "${FILESDIR}"/init-${PVR} foldingathome
	newconfd "${FILESDIR}"/folding-conf.d-r1 foldingathome
}

pkg_preinst() {
	# the bash shell is important for "su -c" in init script
	enewuser foldingathome -1 /bin/bash /opt/foldingathome
}

pkg_postinst() {
	chown -R foldingathome:nogroup /opt/foldingathome
	einfo "To run Folding@home in the background at boot:"
	einfo " rc-update add foldingathome default"
	einfo ""
	einfo "Please run ${I}/initfolding to configure your client"
	einfo "and edit /etc/conf.d/foldingathome for options"
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}
