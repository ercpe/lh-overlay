# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils linux-mod

#MY_P=${P/${PN}-/IS_Linux_STA_6x_D_}
MY_P=${P/${PN}-/2008_0723_RT61_Linux_STA_v}
#MYMY_P="2008_0723_RT61_Linux_STA_v1.1.2.2"

DESCRIPTION="Driver for the RaLink RT61 wireless chipset"
HOMEPAGE="http://www.ralinktech.com/"

SRC_URI="http://www.ralinktech.com.tw/data/drivers/2008_0723_RT61_Linux_STA_v1.1.2.2.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	net-wireless/wireless-tools
	!net-wireless/rt61"

S="${WORKDIR}/${MY_P}"

MODULE_NAMES="rt61(net:${S}/Module)"
BUILD_TARGETS=" "
MODULESD_RT61_ALIASES=('ra? rt61')

CONFIG_CHECK="WIRELESS_EXT"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

src_prepare() {
	epatch \
		"${FILESDIR}"/Makefile.diff \
		"${FILESDIR}"/rtmp_main2.diff
	if kernel_is 2 6; then
		cp Module/Makefile.6 Module/Makefile || die
	elif kernel_is 2 4; then
		cp Module/Makefile.4 Module/Makefile || die
	else
		die "Your kernel version is not supported!"
	fi
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc Module/{ReleaseNote,STA_iwpriv_ATE_usage.txt,README,iwpriv_usage.txt}

	insinto /etc/Wireless/RT61STA
	insopts -m 0600
	doins Module/rt61sta.dat
	insopts -m 0644
	doins Module/{rt2561,rt2561s,rt2661}.bin
}
