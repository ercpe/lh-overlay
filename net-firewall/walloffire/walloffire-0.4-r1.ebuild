# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A simple bash-based firewall using iptables"
HOMEPAGE="http://www.j-schmitz.net/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-firewall/walloffire/${P}.tar.xz"

IUSE=""
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=net-firewall/iptables-1.3.8
	>=sys-apps/openrc-0.11"
DEPEND=""

src_prepare() {
	sed '/need net/d' -i init.sh || die
}

src_install() {
	newinitd init.sh firewall

	insinto /etc/walloffire/
	doins -r rules walloffire.conf

	doconfd firewall

	dosbin firewall.sh
}

pkg_postinst() {
	echo "";
	einfo "Remember to adjust the rules in /etc/walloffire/rules/ to your needs";
	echo "";
	einfo "To start the firewall at system boot, run: rc-update add firewall boot";
	echo "";
}
