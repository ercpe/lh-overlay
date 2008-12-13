# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A simple bash-based firewall using iptables"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage/distfiles/net-firewall/walloffire/${P}.tar.bz2"
RESTRICT="mirror"
IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"

RDEPEND=">=net-firewall/iptables-1.3.8"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {
	newinitd init.sh firewall

	insinto /etc/walloffire/
	doins walloffire.conf

	dodir /etc/walloffire/rules/started/
	dodir /etc/walloffire/rules/stopped/
	
	insinto /etc/walloffire/rules/started/
	doins rules/started/*

	insinto /etc/walloffire/rules/stopped/
	doins rules/stopped/*

	dosbin firewall.sh
}

pkg_postinst() {
	echo "";
	einfo "Remember to adjust the rules in /etc/walloffire/rules/ to your needs";
	echo "";
	einfo "To start the firewall at system boot, run: rc-update add firewall boot";
	echo "";
}