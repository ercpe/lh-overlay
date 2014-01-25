# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-info

REL="130321"
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

QA_PREBUILT=( opt/bin/* )

ARCMSR_kernel_info() {
	cat <<- EOF
	The Areace CLI needs a kernel driver (CONFIG_ARCMSR):
	  Device Drivers --->
	    SCSI device support --->
	      SCSI low-level drivers --->
	         <*>   ARECA (ARC11xx/12xx/13xx/16xx) SATA/SAS RAID Host Adapter
	EOF
}

CONFIG_CHECK="~ARCMSR"
ERROR_ARCMSR="$(ARCMSR_kernel_info)"

src_install() {
	exeinto /opt/bin

	if use amd64; then
		newexe "${S}"/64/cli64 arccli
	else
		newexe "${S}"/32/cli32 arccli
	fi
}
