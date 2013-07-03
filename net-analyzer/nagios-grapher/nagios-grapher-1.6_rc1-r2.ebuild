# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils user

DESCRIPTION="Daemon and CGIs for getting quite pretty charts out of nagios"
HOMEPAGE="http://www.nagiosexchange.org/NagiosGrapher.84.0.html/"
SRC_URI="
	http://de.geocities.com/fencheltee84/nagios/nagios-grapher-1.6.tar.gz
	http://de.geocities.com/fencheltee84/nagios/nagios-grapher-${PVR}.gentoo-patchset.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-perl/GDGraph-1.43
	>=dev-perl/Image-Imlib2-1.13
	>=dev-perl/XML-NamespaceSupport-1.09
	>=dev-perl/XML-SAX-0.14
	>=dev-perl/XML-Dumper-0.81
	>=dev-perl/URI-1.3.5
	>=dev-lang/perl-5.8.7-r3
	>=net-analyzer/rrdtool-1.2.6-r1
	>=media-gfx/imagemagick-6.2.5.5
	>=net-analyzer/nagios-2.5"
RDEPEND="${DEPEND}"

RESTRICT="mirror"

S="${WORKDIR}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PVR}/collect2.pl.patch \
		"${FILESDIR}"/${PVR}/config.layout.patch \
		"${FILESDIR}"/${PVR}/configure.patch \
		"${FILESDIR}"/${PVR}/ngraph.ncfg.in.patch \
		"${FILESDIR}"/${PVR}/Makefile.in.patch

	cp "${FILESDIR}"/${PVR}/nagios-grapher.in . || die
}

src_configure() {
	./configure --with-layout=gentoo --with-ng-interface=pipe || die "./configure failed"
}

src_compile() {
	cd  "${WORKDIR}"/contrib/fifo_write/C
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} fifo_write.c -o fifo_write || die
	cd  "${WORKDIR}"/contrib/udpecho
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} udpecho.c -o udpecho || die
}

src_install() {
	insinto /etc/nagios/
	doins cfg/ngraph.ncfg

	insinto /usr/nagios/share/images
	doins dot.png graph.png

	exeinto /usr/nagios/sbin
	doexe graphs.cgi rrd2-graph.cgi rrd2-system.cgi

	exeinto /usr/nagios/contrib
	doexe collect2.pl contrib/fifo_write/C/fifo_write contrib/udpecho/udpecho

	exeinto /etc/perl
	doexe NagiosGrapher.pm

	exeinto /etc/init.d
	doexe nagios-grapher

	cd doc
	dodoc ABOUT AUTHORS CHANGELOG CONFIG INSTALL LAYOUT VERSION
	docinto examples
	cd examples
	dodoc README TIPS
	cd advanced
	dodoc linux-disk-usage.cfg linux-load.cfg net-ping.cfg openvpn-clients.cfg
	cd ../basic
	dodoc linux-procs.cfg linux-swap.cfg linux-users.cfg net-ldap.cfg
}

pkg_postinst() {
	echo
	einfo "To complete the installation you have to make sure"
	einfo "nagios and nagios-grapher understand each other."
	echo
	einfo "So please check the following lines in '/etc/nagios/nagios.cfg':"
	einfo "    process_performance_data=1"
	einfo "    service_perfdata_command=process-service-perfdata"
	echo
	einfo "You should also define the following within your nagios config:"
	einfo "    define command { "
	einfo "        command_name    process-service-perfdata "
	einfo "        command_line    echo -e '\$HOSTNAME\$\\\t\$SERVICEDESC$\\\t\$SERVICEOUTPUT$\\\t\$SERVICEPERFDATA\$' > /var/nagios/rw/ngraph.pipe"
	einfo "    }"
	echo
	einfo "Don't forget to add nagios-grapher to your favorite runlevel."
	einfo "To do this please type: 'rc-update add nagios-grapher default'"
	echo
	einfo "Just in case: the docs are located in /usr/share/doc/${PF}"
	echo
}
