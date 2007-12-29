inherit eutils autotools

DESCRIPTION=" ARP/wARP is a software suite for improvement and objective interpretation of crystallographic electron density maps and automatic construction and refinement of macromolecular models"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sci-chemistry/arp_warp/${P}.tar.gz"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
LICENSE="GPL-2"
RESTRICT="fetch primaryuri"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="curl"
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 >=sci-chemistry/ccp4-6
	 sys-apps/coreutils
	 sys-apps/gawk
	 >dev-lang/python-2.2
	 curl? ( net-misc/curl )
	 app-portage/fetch_restricted"
DEPEND="${RDEPEND}"

pkg_nofetch(){
        einfo "Fill out the form at http://www.embl-hamburg.de/ARP/"
        einfo "and place these files:"
        einfo "${A}"
        einfo "in ${DISTDIR}"
        einfo "or run"
        einfo "fetch_restricted ${A}"
}
src_unpack() {
	unpack ${A}
}

src_compile(){
	cd "arp_warp_7.0/flex-wARP-src"
	python ./compile.py||die
}

src_install(){
	PYTHON_VER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	testcommand=`echo 3 2 | awk '{printf"%3.1f",$1/$2}'`
	if [ $testcommand == "1,5" ]
	then
	  einfo "*** ERROR ***"
	  einfo "   3/2=" $testcommand
	  einfo "Invalid decimal separator (must be ".")"
	  einfo
	  einfo "One way of setting the decimal separator is:"
	  einfo "setenv LC_NUMERIC C' in your .cshrc file"
	  einfo "Otherwise please consult your system manager"
	  die
	fi

	namesystem=`uname`
	nameprocessor=`uname -m | sed -e 's/ //g'`
	dodir /usr/lib/arp_warp_7.0/bin/bin-$nameprocessor-$namesystem
	exeinto /usr/lib/arp_warp_7.0/bin/bin-$nameprocessor-$namesystem
	exeopts -m0775
	doexe arp_warp_7.0/bin/bin-$nameprocessor-$namesystem/* ||die

	dodir "/usr/lib/arp_warp_7.0/byte-code/python-"$PYTHON_VER
	exeinto "/usr/lib/arp_warp_7.0/byte-code/python-"$PYTHON_VER
	doexe arp_warp_7.0/flex-wARP-src/*pyc

	dodir /usr/lib/arp_warp_7.0/flex-wARP-src-214
	insinto /usr/lib/arp_warp_7.0/flex-wARP-src-214
	doins arp_warp_7.0/flex-wARP-src/*py
	dosym /usr/lib/arp_warp_7.0/flex-wARP-src-214 /usr/lib/arp_warp_7.0/flex-wARP-src

	dodir /usr/share/arp_warp_7.0/share
	exeinto /usr/share/arp_warp_7.0/share
	doexe arp_warp_7.0/share/*

	for i in `ls ${D}usr/share/arp_warp_7.0/share/`
	do
		dosym /usr/share/arp_warp_7.0/share/$i /usr/lib/arp_warp_7.0/bin/bin-i686-Linux/$i
	done

	exeopts "-m0775"
	exeinto "/usr/lib/arp_warp_7.0"
	doexe ${FILESDIR}/arpwarp_setup*

	dodoc "arp_warp_7.0/README"
	dodir /usr/share/doc/${PF}
	insinto /usr/share/doc/${PF}
	doins -r arp_warp_7.0/examples arp_warp_7.0/manual arp_warp_7.0/ARP_wARP_GUI.tar.gz
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
    einfo " when you downloaded ARP/wARP 7.0. Proceeding with installation reinforces"
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
	einfo "source /usr/lib/arp_warp_7.0/arpwarp_setup.csh"
	einfo ""
	einfo "If you prefer to use bash, add the following line in your .bashrc or .bash_profile file:"
	einfo "source /usr/lib/arp_warp_7.0/arpwarp_setup.bash"
	einfo ""
	einfo "The ccp4 interface file can be found in /usr/share/doc/"${P}
	einfo ""
}
