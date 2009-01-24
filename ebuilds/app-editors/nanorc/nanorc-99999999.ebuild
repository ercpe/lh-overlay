# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git

DESCRIPTION="Some more nanorc files"
EGIT_REPO_URI="git://ssh.j-schmitz.net/nanorc.git"
HOMEPAGE="http://www.j-schmitz.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 "
IUSE=""
RESTRICT="primaryuri mirror"
RDEPEND="app-editors/nano"
DEPEND="${RDEPEND}"

pkg_setup(){
	ewarn "This package is evil!"
	ebeep
	ewarn "because it will overwrite alot of files which belongs to other packages"
	ewarn 'You might want to add CONFIG_PROTECT="/usr/share/nano/ ${CONFIG_PROTECT}"'
	ewarn "to your make.conf"
	sleep 5
}

src_install() {
	insinto /usr/share/nano/
	doins *
}
