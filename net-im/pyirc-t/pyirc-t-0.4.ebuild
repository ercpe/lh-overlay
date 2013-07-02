# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils multilib python-r1

DESCRIPTION="Python based jabber transport for IRC"
HOMEPAGE="http://xmpppy.sourceforge.net/irc/"
SRC_URI="mirror://sourceforge/xmpppy/irc-transport-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
	net-im/jabber-base"
RDEPEND="${PYTHON_DEPS}
	>=dev-python/python-irclib-0.4.6
	>=dev-python/twisted-2.2.0
	>=dev-python/twisted-words-0.1.0
	>=dev-python/twisted-web-0.5.0
	>=dev-python/xmpppy-0.4.1
	virtual/python-imaging[${PYTHON_USEDEP}]"

src_install() {
	installation() {
		python_moduleinto ${PN}
		python_domodule irc-transport-${PV}/*.py
	}

	python_parallel_foreach_impl installation

	sed \
		-e "s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		-e "s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		-i irc-transport-${PV}/config_example.xml || die

	insinto /etc/jabber
	newins irc-transport-${PV}/config_example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml

	dosym jabber/${PN}.xml /etc/pyirct.conf.xml

	newinitd "${FILESDIR}/${PN}-${PV}-initd" ${PN}
	sed -e "s:INSPATH:${inspath}:" -i "${ED}"/etc/init.d/${PN} || die
}

pkg_postinst() {
	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."
}
