# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Checks for security updates insite the portage system."
#SRC_URI="http://www.nagiosexchange.org/cgi-bin/jump.cgi?ID=1539&view=File1"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-analyzer/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.nagiosexchange.org/cgi-bin/jump.cgi?ID=1539&view=File1"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}"/nagios-plugins-portage

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/
	doexe check_gentoo_portage || die
}