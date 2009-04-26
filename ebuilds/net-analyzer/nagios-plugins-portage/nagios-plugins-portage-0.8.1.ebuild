# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $



SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Checks for security updates insite the portage system."
#SRC_URI="http://www.nagiosexchange.org/cgi-bin/jump.cgi?ID=1539&view=File1"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/net-analyzer/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.nagiosexchange.org/cgi-bin/jump.cgi?ID=1539&view=File1"
IUSE=""
RESTRICT="mirror"

src_install(){
	exeinto /usr/nagios/libexec
	doexe check_gentoo_portage
}