# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils multilib python-single-r1 user

DESCRIPTION="A set of extra nagios plugins"
HOMEPAGE="http://www.j-schmitz.net/projects/nagios-plugins-extra/"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

SLOT="0"
LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"
IUSE="bind fail2ban pnp4nagios sensors"

DEPEND=""
RDEPEND="
	net-dns/bind-tools
	bind? ( net-dns/bind )
	fail2ban? ( app-admin/sudo net-analyzer/fail2ban )
	pnp4nagios? ( net-analyzer/pnp4nagios )
	sensors? ( sys-apps/lm_sensors dev-python/pysensors )"

S="${WORKDIR}"/nagios-plugins-extra
SP="${WORKDIR}"/pnp-templates

CHECK_SCRIPTS=(
	check_gentoo_portage check_apachestatus.pl check_fw_conntrack.sh
	check_mysql_status.sh check_mem.sh check_dnsbl.sh check_traffic_proc.py
	check_entropy.sh amavis-timings.py )
TEMPLATES=(
	check_apache.php check_bind.php check_conntrack.php check_cpu.php
	check_fail2ban.php check_maillog.php check_mailstats.php check_memcached.php
	check_memory.php check_mysql_snmp.php check_mysql_status.php check_nrpe.cfg
	check_spamassassin.php check_traffic.php check_amavis_timings.php check_sensors.php )

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
	python-single-r1_pkg_setup
}

src_install(){
	exeinto /usr/$(get_libdir)/nagios/plugins/extra/

	for x in ${CHECK_SCRIPTS[@]}; do
		inst_check $x
	done

	use fail2ban && inst_check check_fail2ban.sh
	use bind && inst_check check_bind.sh
	use sensors && inst_check check_sensors.py
	if use pnp4nagios; then
		cd $SP || die
		insinto /usr/share/pnp/templates/

		for x in $TEMPLATES[@]; do
			doins $x
		done

		insinto /etc/pnp/check_commands/
		doins check_nrpe.cfg
		dosym /etc/pnp/check_commands/check_nrpe.cfg /etc/pnp/check_commands/check_nrpe_args.cfg
	fi

	dosym /usr/$(get_libdir)/nagios/plugins/utils.sh /usr/$(get_libdir)/nagios/plugins/extra/utils.sh
	dosym /usr/$(get_libdir)/nagios/plugins/utils.pm /usr/$(get_libdir)/nagios/plugins/extra/utils.pm
	python_fix_shebang "${ED}"/usr/$(get_libdir)/nagios/plugins/extra/
}

pkg_postinst() {
	use fail2ban && einfo "Remember to grant the nagios user to execute fail2ban-client via sudo."
}

inst_check() {
	doexe $1
	fowners -R root:nagios /usr/$(get_libdir)/nagios/plugins/extra/$1
	fperms -R o-rwx /usr/$(get_libdir)/nagios/plugins/extra/$1
}
