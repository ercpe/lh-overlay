# Copyright 1999-2010 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id $

# mysql-snmp-9999       -> latest git
# mysql-snmp-VER        -> normal MIB release

EAPI="2"

if [[ ${PV} == 9999* ]]
then
	EGIT_REPO_URI="git://github.com/masterzen/mysql-snmp.git"
	inherit git eutils multilib
	SRC_URI=""
	S=${WORKDIR}/${PN}
else
	inherit eutils multilib
	SRC_URI="http://github.com/masterzen/${PN}/tarball/v${PV} -> ${P}.tar.gz"
fi

DESCRIPTION="AgentX subagent for net-snmp to get MySQL statistics"
HOMEPAGE="http://github.com/masterzen/mysql-snmp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# We do not need anything to build, since we're just a perl script.
DEPEND=""
# We do not need mysql, since we use the perl DBI
RDEPEND="dev-lang/perl
	>=net-analyzer/net-snmp-5.4.2[perl]
	dev-perl/DBI
	dev-perl/Unix-Syslog
	virtual/perl-Getopt-Long"

src_unpack() {
	if [[ ${PV} == 9999* ]] ; then
		git_src_unpack
	else
		unpack ${A}
		mv masterzen-mysql-snmp-* ${P}
	fi
}

src_install() {
	# Do not use make install, since it installs the MIB
	newsbin mysql-agent ${PN} || die
	newman mysql-agent.1 ${PN}.1 || die
	newinitd "${FILESDIR}"/${PN}.rc ${PN} || die
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
	dodoc README
}
