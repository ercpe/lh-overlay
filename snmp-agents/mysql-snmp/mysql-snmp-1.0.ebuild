# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils multilib vcs-snapshot

DESCRIPTION="AgentX subagent for net-snmp to get MySQL statistics"
HOMEPAGE="http://github.com/masterzen/mysql-snmp"
SRC_URI="http://github.com/masterzen/${PN}/tarball/v${PV} -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

# We do not need anything to build, since we're just a perl script.
DEPEND=""
# We do not need mysql, since we use the perl DBI
RDEPEND="
	dev-lang/perl
	>=net-analyzer/net-snmp-5.4.2[perl]
	dev-perl/DBI
	dev-perl/Unix-Syslog
	virtual/perl-Getopt-Long"

src_install() {
	# Do not use make install, since it installs the MIB
	newsbin mysql-agent ${PN}
	newman mysql-agent.1 ${PN}.1
	newinitd "${FILESDIR}"/${PN}.rc ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	dodoc README
}
