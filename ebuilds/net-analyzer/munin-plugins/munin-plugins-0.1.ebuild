# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="Collection of 3rd party plugins for net-analyzer/munin"
SRC_URI="http://gentoo.j-schmitz.net/private-overlay/distfiles/net-analyzer/munin-plugins/${P}.tar.bz2"
HOMEPAGE="http://www.j-schmitz.net"
IUSE="lighttpd mysql postfix proftpd spamassassin ntp"
RESTRICT="primaryuri"

RDEPEND="net-analyzer/munin
			lighttpd? ( www-servers/lighttpd )
			mysql? ( dev-db/mysql )
			postfix? ( mail-mta/postfix >=app-admin/logsentry-1.1.1 )
			proftpd? ( net-ftp/proftpd >=app-admin/logsentry-1.1.1 )
			spamassassin? ( mail-filter/spamassassin )
			ntp? ( net-misc/ntp )"

DEPEND="${RDEPEND}"

PLUGIN_DIR="/usr/libexec/munin-plugins/"

src_install() {

	if use lighttpd
	then
		exeinto $PLUGIN_DIR
		doexe lighttpd_*

		einfo "To use the lighttpd plugins add (or extend an already existing section) named [lighttpd_*] in your /etc/munin/plugin-conf.d/munin-node"
		einfo "The resulting section should look like this:"
		einfo "  [lighttpd_*]"
		einfo "  user root"
		einfo ""
		einfo ""
		einfo "If you want to use the lighttpd status code plugin, you have to use simple-vhost, use per-domain access logs (by setting accesslog.filename on "
		einfo "a per-domain basis) and extend your [lighttpd_*] section:"
		einfo ""
		einfo "env.logpath <base-dir>/%s/<optional-sub-dir>/<logfile-name>"
		einfo ""
		einfo "where <base-dir> points to the same dir as simple-vhost.server-root"
		einfo "Now, create one symlink per domain in /etc/munin/plugins/ pointing to ${PLUGIN_DIR}/lighttpd_http_codes.pl named lighttpd_http_codes_<domain-name>.pl"
		einfo ""
		einfo "To use lighttp_{accesses|volume} configure the lighttpd status url (status.status-url) and add a line to your lighttpd-section:"
		einfo " env.url http://127.0.0.1:%d/lighttpd-server-status?auto"
	fi

	if use mysql
	then
		exeinto $PLUGIN_DIR;
		doexe mysql_*

		einfo "To use the mysql plugins, create a mysql-user with the following rights:  PROCESS, REFERENCES, SHOW DATABASES"
		einfo "and a config-file with the following content:"
		einfo ""
		einfo "[client]"
		einfo "host     = <database-hostname>"
		einfo "user     = <database-username>"
		einfo "password = <database-password>"
		einfo "socket   = /var/run/mysqld/mysqld.sock"
		einfo ""
		einfo "Now configure your /etc/munin/plugin-conf.d/munin-node. Add a section like this:"
		einfo "  [mysql*]"
		einfo "  env.mysqlopts --defaults-extra-file=<path-to-your-config-file>"
	fi

	if use postfix
	then
		exeinto $PLUGIN_DIR;
		doexe postfix_*

		einfo "Add a section to /etc/munin/plugin-conf.d/munin-node:"
		einfo "  [postfix_mailfiltered]"
		einfo "  user root"
		einfo "  group root"
	fi

	if use proftpd
	then
		exeinto $PLUGIN_DIR;
		doexe proftpd_*

		einfo "Add a section to /etc/munin/plugin-conf.d/munin-node:"
		einfo "  [proftpd_*]"
		einfo "  user root"
		einfo "  group root"
	fi

	if use spamassassin
	then
		exeinto $PLUGIN_DIR;
		doexe spamassassin

		einfo "Add a section to /etc/munin/plugin-conf.d/munin-node like this:"
		einfo "  [spam*]"
		einfo "  user root"
		einfo "  group root"
		einfo "  env.logdir /var/log/"
		einfo "  env.logfile mail.log"
	fi

	if use ntp
	then
		exeinto $PLUGIN_DIR;
		doexe ntpdate_

		einfo "Create a symlink /etc/munin/plugins/ pointing to ${PLUGIN_DIR}/ntpdate_ named ntpdate_<your-ntp-server>"
		einfo "For the german ntp-server of Physikalisch-Technische Universitaet Braunschweig the link would look like this:"
		einfo "   ntpdate_ntp1_ptb_de"
	fi
}
