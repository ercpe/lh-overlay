# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

SLOT="0"
LICENSE="AS-IS"
KEYWORDS="x86 amd64"
DESCRIPTION="A set of extra nagios plugins"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-analyzer/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net/"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}"/nagios-plugins-extra

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/extra/

	for x in check_gentoo_portage check_apachestatus.pl check_apachestatus_auto.pl check_fw_conntrack.sh check_mysql_status.sh check_mem.sh; do
		doexe $x || die
		chown -R root:nagios "${D}"/usr/$(get_libdir)/nagios/plugins/extra/$x || die "Failed chown of ${D}usr/$(get_libdir)/nagios/plugins/extra/$x"
		chmod -R o-rwx "${D}"/usr/$(get_libdir)/nagios/plugins/extra/$x || die "Failed chmod of ${D}usr/$(get_libdir)/nagios/plugins/extra/$x"
	done

    dosym /usr/$(get_libdir)/nagios/plugins/utils.sh /usr/$(get_libdir)/nagios/plugins/extra/utils.sh
    dosym /usr/$(get_libdir)/nagios/plugins/utils.pm /usr/$(get_libdir)/nagios/plugins/extra/utils.pm
}