# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils rpm

UPSTREAM_PV="1.0.5-1"

DESCRIPTION="Sane drivers for Brother DS 620"
HOMEPAGE="http://support.brother.com/g/b/producttop.aspx?c=us&lang=en&prod=ds620_all"

SRC_URI="http://support.brother.com/g/b/downloadlist.aspx?c=us&lang=en&prod=ds620_all&os=127 -> libsane-dsseries-${UPSTREAM_PV}.x86_64.rpm"

LICENSE="Brother-DSSeries"

SLOT="0"
KEYWORDS="~amd64"

IUSE=""
RESTRICT="fetch strip"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack libsane-dsseries-${UPSTREAM_PV}.x86_64.rpm
	rm -r "${S}/usr/local" "${S}/etc/udev/" || die
}

src_install() {
	doins -r *
}
