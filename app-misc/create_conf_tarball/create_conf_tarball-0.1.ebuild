inherit eutils

DESCRIPTION="Creating tarball for app-misc/fetch_fonfig"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/create_conf_tarball/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="primaryuri"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
}


src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	doexe create_conf_tarball
	dodir /etc
	insinto /etc/
	doins create_conf_tarball.ini
}

