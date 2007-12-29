inherit eutils

DESCRIPTION="royale readahead after http://forums.gentoo.org/viewtopic-t-478491-start-0.html"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/sys-apps/readahead-royale/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RDEPEND="sys-process/lsof
		sys-apps/gawk"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
}


src_install() {
	dodir /etc/init.d/ /usr/sbin/
	insinto /etc/
	doins readahead-royale.conf
	exeinto /etc/init.d/
	doexe readahead-royale
	exeinto /usr/sbin/
	doexe uniquer sample-init-process
	touch ${D}/forcesampler
}

pkg_postinst(){
	einfo
	einfo "Remember to add readahead-royale to the default runlevel"
	einfo "rc-update add readahead-royale default"
	einfo
	einfo "To create a new list just"
	einfo "touch /forcesampler"
}
