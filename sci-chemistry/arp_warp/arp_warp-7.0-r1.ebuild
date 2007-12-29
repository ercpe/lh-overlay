inherit eutils autotools

DESCRIPTION=" ARP/wARP is a software suite for improvement and objective interpretation of crystallographic electron density maps and automatic construction and refinement of macromolecular models"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sci-chemistry/arp_warp/${P}.tar.gz"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
LICENSE="GPL-2"
RESTRICT="fetch primaryuri"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 >=sci-chemistry/ccp4-6
	 sys-apps/coreutils
	 sys-apps/gawk
	 >dev-lang/python-2.2
	 net-misc/curl"
DEPEND="${RDEPEND}"

pkg_nofetch(){
	einfo "Fetch the Arp_Warp source tarball"
}
src_unpack() {
	unpack ${A}
	cd "arp_warp_7.0/bin"
	rm -r bin-alpha-OSF1
	rm -r bin-i386-Darwin
	rm -r bin-ia64-Linux
	rm -r bin-mips-IRIX64
	rm -r bin-powerpc-Darwin
	rm -r bin-athlon-Linux
}


src_install() {
	#correct instal path
	#epatch "${FILESDIR}"/set_all_needed_install_csh.patch
	dodir "/usr/lib/arp_warp_7.0"
	insinto "/usr/lib/arp_warp_7.0"
	doins -r arp_warp_7.0/bin/
	doins -r arp_warp_7.0/byte-code
	doins -r arp_warp_7.0/flex-wARP-src-214
	dosym /usr/share/arp_warp_7.0/flex-wARP-src-214 /usr/share/arp_warp_7.0/flex-wARP-src
	exeopts -m0775
	exeinto "/usr/lib/arp_warp_7.0"
	doexe -r arp_warp_7.0/install.sh
	doexe -r arp_warp_7.0/install_csh.sh
	dodir "/usr/share/arp_warp_7.0"
	insinto "/usr/share/arp_warp_7.0"
	doins -r "arp_warp_7.0/share"
	dosym /usr/share/arp_warp_7.0/share /usr/lib/arp_warp_7.0/share
	dodoc -r "arp_warp_7.0/examples"
	dodoc -r "arp_warp_7.0/manual"
	dodoc -r "arp_warp_7.0/ARP_wARP_GUI.tar.gz"
	dodoc -r "arp_warp_7.0/README"
}

pkg_postinst(){
	echo "Path" `pwd`
	cd /usr/lib/arp_warp_7.0/
	./install.sh
	einfo ""
	einfo "Do not forget to add this line in your .cshrc file:"
	einfo "source /var/tmp/portage/sci-chemistry/arp_warp-7.0-r1/work/arp_warp_7.0/arpwarp_setup.csh"
	einfo ""
	einfo "If you prefer to use bash, add the following line in your .bashrc or .bash_profile file:"
	einfo "source /var/tmp/portage/sci-chemistry/arp_warp-7.0-r1/work/arp_warp_7.0/arpwarp_setup.bash"
	einfo "ccp4 interface can be found in /usr/share/doc"${P}
}
