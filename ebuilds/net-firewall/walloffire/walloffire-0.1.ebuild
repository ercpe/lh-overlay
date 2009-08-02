# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A simple bash-based firewall using iptables"
HOMEPAGE="http://www.j-schmitz.net"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-firewall/walloffire/${P}.tar.bz2"
RESTRICT="mirror"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
# IUSE="symlink"

RDEPEND=">=net-firewall/iptables-1.3.8"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_install() {

	mkdir -p "${D}/usr/local/bin/walloffire/" || die
	mkdir -p "${D}/etc/walloffire/" || die
	mkdir -p "${D}/etc/init.d/" || die

	cp "walloffire.sh" "${D}/usr/local/bin/walloffire/" || die
	chown root:root "${D}/usr/local/bin/walloffire/walloffire.sh" || die
	chmod 770 "${D}/usr/local/bin/walloffire/walloffire.sh" || die

	cp "walloffire.conf" "${D}/etc/walloffire/" || die
	cp "wof-functions.sh" "${D}/etc/walloffire/" || die

	cp rules/* "${D}/etc/walloffire/" || die

	cp gentoo-init "${D}/etc/init.d/walloffire" || die

#	if use symlink; then
#		ln -s /etc/init.d/walloffire /etc/init.d/firewall
#	fi
}
