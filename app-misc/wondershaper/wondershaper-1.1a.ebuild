# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="wondershaper is a QoS script"
HOMEPAGE="http://lartc.org/wondershaper"
SRC_URI="http://lartc.org/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="sys-apps/iproute2"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo-ng.patch
}

src_install() {
	newinitd wshaper ${PN} || die
	newinitd wshaper.htb ${PN}.htb || die
	newconfd "${FILESDIR}"/conf-${PV} ${PN} || die
	dosym ${PN} /etc/conf.d/${PN}.htb || die
	dodoc ChangeLog README TODO || die
}
