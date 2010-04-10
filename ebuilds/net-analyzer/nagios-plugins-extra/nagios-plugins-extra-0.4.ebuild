# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="AS-IS"
KEYWORDS="x86 amd64"
DESCRIPTION="A set of extra nagios plugins"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/net-analyzer/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net/"
IUSE="fail2ban"
RESTRICT="mirror"

DEPEND="fail2ban? ( app-admin/sudo net-analyzer/fail2ban )
	net-dns/bind-tools"

S="${WORKDIR}"/nagios-plugins-extra

CHECK_SCRIPTS="check_gentoo_portage check_apachestatus.pl check_apachestatus_auto.pl check_fw_conntrack.sh check_mysql_status.sh check_mem.sh check_dnsbl.sh"

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/extra/

	for x in $CHECK_SCRIPTS; do
		inst_check $x
	done

	if use fail2ban; then
		inst_check check_fail2ban.sh
	fi

	dosym /usr/$(get_libdir)/nagios/plugins/utils.sh /usr/$(get_libdir)/nagios/plugins/extra/utils.sh
	dosym /usr/$(get_libdir)/nagios/plugins/utils.pm /usr/$(get_libdir)/nagios/plugins/extra/utils.pm
}

pkg_postinst() {
	if use fail2ban; then
		einfo "Remember to grant the nagios user to execute fail2ban-client via sudo."
	fi
}

inst_check() {
	doexe $1 || die
	chown -R root:nagios "${D}"/usr/$(get_libdir)/nagios/plugins/extra/$1 || die "Failed chown of ${D}usr/$(get_libdir)/nagios/plugins/extra/$1"
	chmod -R o-rwx "${D}"/usr/$(get_libdir)/nagios/plugins/extra/$1 || die "Failed chmod of ${D}usr/$(get_libdir)/nagios/plugins/extra/$1"
}
