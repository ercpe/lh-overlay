inherit eutils autotools

DESCRIPTION=" ARP/wARP is a software suite for improvement and objective interpretation of crystallographic electron density maps and automatic construction and refinement of macromolecular models"
SRC_URI="${P}.tar.gz"
HOMEPAGE="http://www.embl-hamburg.de/ARP/"
LICENSE="academic free"
RESTRICT="fetch"
SLOT=""
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="curl gui"
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 >=sci-chemistry/ccp4-6
	 sys-apps/coreutils
	 sys-apps/sed
	 sys-apps/gawk
	 >dev-lang/python-2.2
	 curl? ( net-misc/curl )"
DEPEND="${RDEPEND}"

pkg_nofetch(){
        einfo "Fill out the form at http://www.embl-hamburg.de/ARP/"
        einfo "and place these files: arp_warp_7.0.1.tar.gz"
        einfo "in ${DISTDIR}an rename it to ${A}"
        einfo "or run"
        einfo "fetch_restricted ${A}"
}

pkg_setup(){
	einfo "Checking decimal seperator"
	testcommand=`echo 3 2 | awk '{printf"%3.1f",$1/$2}'`
	if [ $testcommand == "1,5" ];then
	  ewarn "*** ERROR ***"
	  ewarn "   3/2=" $testcommand
	  ewarn "Invalid decimal separator (must be ".")"
	  ewarn
	  ewarn "One way of setting the decimal separator is:"
	  ewarn "setenv LC_NUMERIC C' in your .cshrc file"
	  ewarn "Otherwise please consult your system manager"
	  die
	fi
	einfo "Checking SSE2 extensions availability"
	namesystem=`uname`
	nameprocessor=`uname -m | sed -e 's/ //g'`
	currentplatform="bin-"${nameprocessor}"-"${namesystem}
	# Checking availability of 'SSE2' extensions for platforms where it matters
	if [ $namesystem == "Linux" ]
	then
	  bin/$currentplatform/sse2_detection >& /dev/null
	  if [ $status ]
	  then
	    echo
	    ewarn "							***WARNING***"
	    ewarn "The CPU on this hardware platform is lacking the SSE2 instruction set!"
	  	ewarn "Some executables of ARP/wARP 7.0.1 however depend on these. Take notice that"
	    ewarn "part of the software will not work and consider remote job submission to the"
	    ewarn "dedicated facility at EMBL-Hamburg."
    	echo
	  fi
	fi

			PYTHON_VER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
}

src_unpack() {
	unpack ${A}
	mv arp_warp_7.0.1 ${P}
}

src_compile(){
	cd flex-wARP-src
	python ./compile.py||die "could not compile python stuff"
}

src_install(){

	dodir /usr/lib/${P}/bin/bin-$nameprocessor-$namesystem
	exeinto /usr/lib/${P}/bin/bin-$nameprocessor-$namesystem
	exeopts -m0775
	doexe bin/bin-$nameprocessor-$namesystem/* ||die

	dodir /usr/lib/${P}/byte-code/python-$PYTHON_VER
	exeinto /usr/lib/${P}/byte-code/python-$PYTHON_VER
	doexe flex-wARP-src/*pyc

	dodir /usr/lib/${P}/flex-wARP-src-261
	insinto /usr/lib/${P}/flex-wARP-src-261
	doins flex-wARP-src/*py
	dosym /usr/lib/${P}/flex-wARP-src-261 /usr/lib/${P}/flex-wARP-src

	dodir /usr/share/${P}/share
	exeinto /usr/share/${P}/share
	doexe share/*

	for i in `ls ${D}usr/share/${P}/share/`
	do
		dosym /usr/share/${P}/share/$i /usr/lib/${P}/bin/bin-i686-Linux/$i
	done

	exeopts -m0775
	exeinto /usr/lib/${P}
	newexe ${FILESDIR}/7.0.1_arpwarp_setup.bash arpwarp_setup.bash
	newexe ${FILESDIR}/7.0.1_arpwarp_setup.csh arpwarp_setup.csh

	dodoc README
	dodir /usr/share/doc/${PF}
	insinto /usr/share/doc/${PF}
	doins -r examples manual ARP_wARP_*.tar.gz
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
	einfo "source /usr/lib/arp_warp-7.0.1/arpwarp_setup.csh"
	einfo ""
	einfo "If you prefer to use bash, add the following line in your .bashrc or .bash_profile file:"
	einfo "source /usr/lib/arp_warp-7.0.1/arpwarp_setup.bash"
	einfo ""
	einfo "The ccp4 interface file could be found in /usr/share/doc/"${P}
	einfo ""
}
