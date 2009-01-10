# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/foldingathome/foldingathome-6.02.ebuild,v 1.1 2008/08/03 03:19:58 je_fro Exp $

# no version number on this install dir since upgrades will be using same dir
# (data will be stored here too)
# The clientX files from old foldingathome will remain untouched.
GENTOO_MACHINE=$(uname -m)
I="/opt/foldingathome/${GENTOO_MACHINE}-smp"

inherit eutils

DESCRIPTION="Folding@Home is a distributed computing project for protein folding."
HOMEPAGE="http://folding.stanford.edu/FAQ-SMP.html"
SRC_URI="http://www.stanford.edu/group/pandegroup/folding/release/FAH6.02-Linux.tgz"

LICENSE="folding-at-home"
SLOT="0"

# This is for x86_64 only.
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-apps/baselayout-1.8.0
		>=sys-libs/glibc-2.3.0
		amd64? ( app-emulation/emul-linux-x86-baselibs )"
RDEPEND=""

S="${WORKDIR}"

src_install() {
	exeinto ${I}
#	sed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" -i "${FILESDIR}"/${PV}/initfolding
	newexe "${FILESDIR}"/${PV}/initfolding initfolding
	dosed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" ${I}/initfolding
	doexe fah6 mpiexec
#	sed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" -i "${FILESDIR}"/${PV}/folding-conf.d
	newconfd "${FILESDIR}"/${PV}/folding-conf.d foldingathome
	dosed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" /etc/conf.d/foldingathome
#	sed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" -i "${FILESDIR}"/${PV}/fah-init
	newinitd "${FILESDIR}"/${PV}/fah-init foldingathome
	dosed "s:GENTOO_MACHINE:${GENTOO_MACHINE}:g" /etc/init.d/foldingathome
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
	einfo "This experimental F@H package exists alongside your old data files"
	einfo "in ${I}."
	einfo ""
}

pkg_postrm() {
	einfo "Folding@home data files were not removed."
	einfo " Remove them manually from ${I}"
	einfo ""
}
