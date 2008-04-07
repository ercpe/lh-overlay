# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools python

S=${WORKDIR}/arp_warp_${PV}

DESCRIPTION=" ARP/wARP is a software for improvement and interpretation of crystallographic electron density maps"
SRC_URI="arp_warp_${PV}.tar.gz"
HOMEPAGE="http://www.embl-hamburg.de/ARP/"
LICENSE="ArpWarp"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="-* ~x86" # ~amd64: ccp4 is blocking
IUSE=""
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 >=sci-chemistry/ccp4-6
	 sys-apps/gawk
	 >=dev-lang/python-2.4"
DEPEND=""

pkg_nofetch(){
	einfo "Fill out the form at http://www.embl-hamburg.de/ARP/"
	einfo "and place these files: ${A}"
	einfo "in ${DISTDIR}"
}

S="arp_warp_${PV}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/setup-${PV}.patch
}

src_install(){
	python_version

	insinto /opt/${PN}/byte-code/python-${PYVER}
	doins "${S}"/flex-wARP-src-261/*py

	exeinto /opt/${PN}/bin/bin-`uname -m`-`uname`
	doexe "${S}"/bin/bin-`uname -m`-`uname`/*
	doexe "${S}"/share/*sh

	insinto /opt/${PN}/bin/bin-`uname -m`-`uname`
	doins "${S}"/share/*{gif,XYZ,bash,csh,dat,lib,tbl,llh}

	insinto /etc/profile.d/
	newins "${S}"/share/arpwarp_setup_base.csh arpwarp_setup.csh
	newins "${S}"/share/arpwarp_setup_base.bash arpwarp_setup.sh

	dodoc "${S}"/README
	dohtml -r "${S}"/manual/*
	insinto /usr/share/doc/${PF}
	doins -r "${S}"/{examples,ARP_wARP_CCP4I6.tar.gz}
}

pkg_postinst(){
	python_mod_optimize "${ROOT}"/opt/${PN}/byte-code/python-${PYVER}

	testcommand=$(echo 3 2 | awk '{printf"%3.1f",$1/$2}')
	if [ $testcommand == "1,5" ];then
	  ewarn "*** ERROR ***"
	  ewarn "   3/2=" $testcommand
	  ewarn "Invalid decimal separator (must be ".")"
	  ewarn "You need to set this correctly!!!"
	  ewarn
	  ewarn "One way of setting the decimal separator is:"
	  ewarn "setenv LC_NUMERIC C' in your .cshrc file"
	  ewarn "\tor"
	  ewarn "export LC_NUMERIC=C' in your .bashrc file"
	  ewarn "Otherwise please consult your system manager"
	  epause 10
	fi

	grep -q sse2 /proc/cpuinfo || \
	einfo ""
	einfo "The CPU is lacking SSE2! You should use the cluster at EMBL-Hamburg."
	einfo ""
	einfo "The ccp4 interface file could be found in /usr/share/doc/"${P}
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/opt/${PN}/byte-code/python-${PYVER}
}