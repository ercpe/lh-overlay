# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PYTHON_DEPEND="2"

inherit eutils multilib python

DESCRIPTION="Python based jabber transport for IRC"
HOMEPAGE="http://xmpppy.sourceforge.net/irc/"
SRC_URI="mirror://sourceforge/xmpppy/irc-transport-${PV}.tar.gz"

RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/imaging-1.1
	>=dev-python/python-irclib-0.4.6
	>=dev-python/twisted-2.2.0
	>=dev-python/twisted-words-0.1.0
	>=dev-python/twisted-web-0.5.0
	>=dev-python/xmpppy-0.4.1"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	local inspath

	inspath=$(python_get_sitedir)/${PN}
	insinto ${inspath}
	doins irc-transport-${PV}/*.py || die

	insinto /etc/jabber
	newins irc-transport-${PV}/config_example.xml ${PN}.xml || die
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		/etc/jabber/${PN}.xml || die
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml || die
	dosym /etc/jabber/${PN}.xml /etc/pyirct.conf.xml || die

	newinitd "${FILESDIR}/${PN}-${PV}-initd" ${PN} || die
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN} || die
}

pkg_postinst() {
	python_mod_optimize "$(python_get_sitedir)/${PN}"

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."
}

pkg_postrm() {
	python_mod_cleanup "$$(python_get_sitedir)/${PN}"
}
