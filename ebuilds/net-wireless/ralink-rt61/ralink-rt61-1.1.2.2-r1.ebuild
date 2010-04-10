# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod

DESCRIPTION="Driver for the RaLink RT61 wireless chipset"
HOMEPAGE="http://www.ralinktech.com/"
LICENSE="GPL-2"

#MY_P=${P/${PN}-/IS_Linux_STA_6x_D_}
MY_P=${P/${PN}-/2008_0723_RT61_Linux_STA_v}
#MYMY_P="2008_0723_RT61_Linux_STA_v1.1.2.2"

SRC_URI="http://www.ralinktech.com.tw/data/drivers/2008_0723_RT61_Linux_STA_v1.1.2.2.tar.bz2"

KEYWORDS="-* amd64 x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND="net-wireless/wireless-tools
	!net-wireless/rt61"

S="${WORKDIR}/${MY_P}"

MODULE_NAMES="rt61(net:${S}/Module)"
BUILD_TARGETS=" "
MODULESD_RT61_ALIASES=('ra? rt61')

CONFIG_CHECK="WIRELESS_EXT"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

src_compile() {
	epatch ${FILESDIR}/Makefile.diff
	epatch ${FILESDIR}/rtmp_main2.diff
	if kernel_is 2 6; then
		cp Module/Makefile.6 Module/Makefile
	elif kernel_is 2 4; then
		cp Module/Makefile.4 Module/Makefile
	else
		die "Your kernel version is not supported!"
	fi

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
