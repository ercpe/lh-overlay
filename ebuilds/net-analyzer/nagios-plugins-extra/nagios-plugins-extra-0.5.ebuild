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
IUSE="fail2ban bind pnp4nagios"
RESTRICT="mirror"

DEPEND="fail2ban? ( app-admin/sudo net-analyzer/fail2ban )
		pnp4nagios? ( net-analyzer/pnp4nagios )
		bind? ( net-dns/bind )
		net-dns/bind-tools"

S="${WORKDIR}"/nagios-plugins-extra
SP="${WORKDIR}"/pnp-templates

CHECK_SCRIPTS="check_gentoo_portage check_apachestatus.pl check_fw_conntrack.sh check_mysql_status.sh check_mem.sh check_dnsbl.sh"
TEMPLATES="check_memory.php check_mysql_status.php check_bind.php"

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/extra/

	for x in $CHECK_SCRIPTS; do
		inst_check $x
	done

	if use fail2ban; then
		inst_check check_fail2ban.sh
	fi

	if use bind; then
		inst_check check_bind.sh
	fi

	if use pnp4nagios; then
		cd $SP
		insinto /usr/share/pnp/templates/

		for x in $TEMPLATES; do
			doins $x
		done

		insinto /etc/pnp/check_commands/
		doins check_nrpe.cfg
		dosym /etc/pnp/check_commands/check_nrpe.cfg /etc/pnp/check_commands/check_nrpe_args.cfg
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
