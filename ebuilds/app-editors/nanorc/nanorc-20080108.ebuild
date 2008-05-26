# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils


DESCRIPTION="Some more nanorc files"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/app-editors/nanorc/${P}.tar.bz2"
HOMEPAGE="http://wiki.j-schmitz.net/wiki/Private_Portage_Overlay"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="primaryuri mirror"
RDEPEND="app-editors/nano"
DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/nano/
	doins *
}

pkg_postinst(){
	einfo "php.nanorc added"
	einfo "echo 'include /usr/share/nano/php.nanorc'>>/etc/nanorc"
}

