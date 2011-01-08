# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit git multilib prefix

EGIT_REPO_URI="https://repos.j-schmitz.net/git/pub/squashed-portage.git"

DESCRIPTION="Tools to handle squashed portage"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

RDEPEND="sys-fs/squashfs-tools:0"
DEPEND=""

src_prepare() {
	eprefixify *
	sed -e "s:GENTOOLIBDIR:$(get_libdir):g" -i get-squashed-portage
}

src_install() {
	dodir /var/portage
	keepdir /var/portage
	newinitd ${PN}.init ${PN} || die
	newconfd ${PN}.conf ${PN} || die
	dobin get-squashed-portage || die
}
