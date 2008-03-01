# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools python

DESCRIPTION=" ARP/wARP is a software suite for improvement and objective interpretation of crystallographic electron density maps and automatic construction and refinement of macromolecular models"
SRC_URI="arp_warp_7.0.1.tar.gz"
HOMEPAGE="http://www.embl-hamburg.de/ARP/"
LICENSE="academic-free"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 >=sci-chemistry/ccp4-6
	 sys-apps/gawk
	 >dev-lang/python-2.3"
DEPEND="${RDEPEND}"

pkg_nofetch(){
        einfo "Fill out the form at http://www.embl-hamburg.de/ARP/"
        einfo "and place these files: arp_warp_7.0.1.tar.gz"
}

pkg_setup(){
#	if use gui && built_with_use sci-chemistry/ccp4 X;then
#		einfo "The ArpWarp gui needs sci-chemistry/ccp4 to be build with X"
#		die "sci-chemistry/ccp4 without X"
#	fi
#Adopted from the original installer
	einfo "Checking decimal seperator"
	testcommand=`echo 3 2 | awk '{printf"%3.1f",$1/$2}'`
	if [ $testcommand == "1,5" ];then
	  ewarn "*** ERROR ***"
	  ewarn "   3/2=" $testcommand
	  ewarn "Invalid decimal separator (must be ".")"
#	  ewarn
#	  ewarn "One way of setting the decimal separator is:"
#	  ewarn "setenv LC_NUMERIC C' in your .cshrc file"
#	  ewarn "\tor"
#	  ewarn "export LC_NUMERIC C' in your .bashrc file"
#	  ewarn "Otherwise please consult your system manager"
	  die
	fi
	einfo "Checking SSE2 extensions availability"
	namesystem=`uname`
	nameprocessor=`uname -m | sed -e 's/ //g'`
	currentplatform="bin-"${nameprocessor}"-"${namesystem}
	# Checking availability of 'SSE2' extensions for platforms where it matters
	if [ $namesystem == "Linux" ]; then
	  bin/$currentplatform/sse2_detection >& /dev/null
	  if [ $status ];then
	    echo
	    ewarn "							***WARNING***"
	    ewarn "The CPU on this hardware platform is lacking the SSE2 instruction set!"
	  	ewarn "Some executables of ARP/wARP 7.0.1 however depend on these. Take notice that"
	    ewarn "part of the software will not work and consider remote job submission to the"
	    ewarn "dedicated facility at EMBL-Hamburg."
    	echo
	  fi
	fi
}

src_unpack() {
	unpack ${A}
	mv arp_warp_7.0.1 ${P}
}

src_compile(){
	cd flex-wARP-src
	for i in `ls *py`;do
		python_mod_compile $i
	done
}

src_install(){
	python_version
	insinto /opt/${P}/byte-code/python${PYVER}
	doins flex-wARP-src/*{pyc,pyo} ||die "python-code"

#	insinto /opt/${P}/flex-wARP-src-261
#	doins flex-wARP-src-261/*py
#	dosym /opt/${P}/flex-wARP-src-261 /usr/lib/${P}/flex-wARP-src

	exeinto /opt/${P}/bin/bin-`uname -m`-`uname`
	doexe bin/bin-`uname -m`-`uname`/* ||die "executables"

	exeinto /opt/${P}/share
	doexe share/*sh
	insinto /opt/${P}/share
	doins share/*{gif,XYZ,bash,csh,dat,lib,tbl,llh}

	for i in `ls ${D}opt/${P}/share/`
	do
		dosym /opt/${P}/share/$i /opt/${P}/bin/bin-`uname -m`-`uname`/$i
	done

#	exeinto /usr/lib/${P}
#	newexe ${FILESDIR}/7.0.1_arpwarp_setup.bash arpwarp_setup.bash
#	newexe ${FILESDIR}/7.0.1_arpwarp_setup.csh arpwarp_setup.csh

	sed 's:arpwarphome="$1X":arpwarphome="/opt/${P}":'<share/arpwarp_setup_base.bash>${T}/arpwarp_setup.bash
	sed 's:arpwarphome="$1X":arpwarphome="/opt/${P}":'<share/arpwarp_setup_base.csh>${T}/arpwarp_setup.csh
	
	insinto /usr/share/${P}/
	doins ${T}/arpwarp_setup.{bash,csh}

	dodoc README
	dohtml -r manual/*
	insinto /usr/share/doc/${PF}
	doins -r examples ARP_wARP_CCP4I6.tar.gz
}

pkg_postinst(){
	if use !curl
	then
		einfo ""
		einfo "Warning about missing curl:"
		einfo "without curl the remote job feature couldn't be used"
	fi
    einfo ""
    einfo "========================================================================="
    einfo "   Remember that you have accepted the terms of the license agreement"
    einfo " when you downloaded ARP/wARP 7.0.1. Proceeding with installation reinforces"
    einfo "                 your acceptance of the license agreement"
    einfo "                A main obligation of this agreement is that"
    einfo "     any reference to the software for crystallographic computations"
    einfo "          will cite one or more ARP/wARP publications as set forth"
    einfo "               in the manual and on http://www.arp-warp.org"
    einfo "========================================================================="
    einfo ""
    einfo "                      *** IMPORTANT FOR SETUP ***"
    einfo ""
	einfo ""
	einfo "Do not forget to add this line in your .cshrc file:"
	einfo "source /usr/share/${P}/arp_warp-7.0.1/arpwarp_setup.csh"
	einfo ""
	einfo "If you prefer to use bash, add the following line in your .bashrc or .bash_profile file:"
	einfo "source /usr/lib/arp_warp-7.0.1/arpwarp_setup.bash"
	einfo ""
	einfo "The ccp4 interface file could be found in /usr/share/doc/"${P}
	einfo ""
}
