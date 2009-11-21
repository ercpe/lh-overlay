# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
DESCRIPTION="A set of extra nagios plugins"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-analyzer/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net/"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}"/nagios-plugins-extra

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/extra/
	doexe check_gentoo_portage || die
	doexe check_apachestatus.pl || die
	doexe check_apachestatus_auto.pl || die

    dosym /usr/$(get_libdir)/nagios/plugins/utils.sh /usr/$(get_libdir)/nagios/plugins/extra/utils.sh
    dosym /usr/$(get_libdir)/nagios/plugins/utils.pm /usr/$(get_libdir)/nagios/plugins/extra/utils.pm
}