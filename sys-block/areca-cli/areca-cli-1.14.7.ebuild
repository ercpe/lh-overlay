# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

REL="150519"
MY_PV="V${PV}_${REL}"

DESCRIPTION="CLI for Areca RAID controllers"
HOMEPAGE="http://www.areca.com.tw/support/s_linux/linux.htm"
SRC_URI="http://www.areca.us/support/s_linux/cli/linuxcli_${MY_PV}.zip -> ${PN}-${MY_PV}.zip"

LICENSE="Areca"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# 2.1.2 of the license forbids modification to the binaries
RESTRICT="strip"

S="${WORKDIR}/linuxcli_${MY_PV}"

QA_PREBUILT="/opt/bin/arccli"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists || ! linux_chkconfig_present ARCMSR; then
		ewarn "The Areca CLI needs a kernel driver (CONFIG_ARCMSR):"
		ewarn "  Device Drivers --->"
		ewarn "	SCSI device support --->"
		ewarn "	  SCSI low-level drivers --->"
		ewarn "		 <*>   ARECA (ARC11xx/12xx/13xx/16xx) SATA/SAS RAID Host Adapter"
	fi
}

src_install() {
	exeinto /opt/bin

	if use amd64; then
		newexe "${S}"/x86_64/cli64 arccli
	else
		newexe "${S}"/i386/cli32 arccli
	fi
}
