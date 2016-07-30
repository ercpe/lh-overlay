# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

REL="150519"
MY_PV="V${PV}_${REL}"

DESCRIPTION="HTTP proxy for Areca RAID controllers without native HTTP interface"
HOMEPAGE="http://www.areca.com.tw/support/s_linux/linux.htm"
SRC_URI="http://www.areca.us/support/s_linux/http/Linuxhttp_${MY_PV}.zip -> ${PN}-${MY_PV}.zip"

LICENSE="Areca"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# 2.1.2 of the license forbids modification to the binaries
RESTRICT="strip"

S="${WORKDIR}/Linuxhttp_${MY_PV}"

src_install() {
	exeinto /opt/archttp

	if use amd64; then
		newexe "${S}"/x86_64/archttp64 archttp
	else
		newexe "${S}"/i386/archttp32 archttp
	fi

	insinto /opt/archttp
	doins "${FILESDIR}"/archttpsrv.conf
	dosym /opt/archttp/archttpsrv.conf /etc/archttpsrv.conf

	newinitd "${FILESDIR}"/archttp.initd archttp
}

pkg_postinst() {
	einfo "The HTTP proxy default binding is 127.0.0.1, port 8081."
	einfo "You can change this in /etc/archttpsrv.conf or in the http interface"
}
