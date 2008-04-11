# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT="0"
LICENSE="ccp4"
KEYWORDS="~x86"
DESCRIPTION="Mosflm is a program for integrating single crystal diffraction data from area detectors."
SRC_URI="http://www.mrc-lmb.cam.ac.uk/harry/mosflm/ver703/build-it-yourself/mosflm703.tgz"
HOMEPAGE="http://www.mrc-lmb.cam.ac.uk/harry/mosflm/"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/mosflm703

pkg_setup(){
	MOSROOT="${D}"/usr/lib/mosflm

	[[ -n $CCP4 || -n $CLIB ]] || die "Please source /etc/profile first"
	#set corected HOSTTYPE
	# ncurses header
}

src_compile(){
	. setup
	emake
}