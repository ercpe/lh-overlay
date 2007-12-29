inherit eutils

DESCRIPTION="Script to fetch restricted packages from private ftp-server ftp://j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-portage/fetch_restricted/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="axel"
RESTRICT="primaryuri"
RDEPEND="axel? ( net-misc/axel )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}


src_install() {
	echo ""
	einfo "Need USER and PASS for the download from ftp://j-schmitz.net"
	echo ""
	echo "[USER]" && read user
	echo "[PASS]"
	stty -echo
	read pass
	stty echo
	sed -i -e s/ftp_user=/ftp_user=$user/  ${S}/fetch_restricted
	sed -i -e s/ftp_pass=/ftp_pass=$pass/  ${S}/fetch_restricted ||die
	if use axel
	   then
	     sed -i s/axel=no/axel=yes/ fetch_restricted
	fi
	dodir /usr/bin
	exeinto /usr/bin
	doexe fetch_restricted
}

