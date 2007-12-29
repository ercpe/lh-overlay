inherit eutils


DESCRIPTION="Fetching tarball with presaved config files"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-misc/fetch_config/fetch_config_justin.tar.bz2
		http://gentoo.j-schmitz.net/portage/distfiles/app-misc/fetch_config/fetch_config_johann.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="primaryuri mirror"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	if use johann
	then
		unpack fetch_config_johann.tar.bz2
	fi
    if use justin
    then
        unpack fetch_config_justin.tar.bz2
    fi
}


src_install() {
	doins -r *
}

