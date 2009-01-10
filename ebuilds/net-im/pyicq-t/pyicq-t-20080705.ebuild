# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON=2.3

inherit eutils multilib python private

DESCRIPTION="Python based jabber transport for ICQ"
HOMEPAGE="http://code.google.com/p/pyicqt/"
SRC_URI="${PKG_SERVER}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="webinterface"

DEPEND="net-im/jabber-base"
RDEPEND="${DEPEND}
	>=dev-python/twisted-2.2.0
	>=dev-python/twisted-words-0.1.0
	>=dev-python/twisted-web-0.5.0
	webinterface? ( >=dev-python/nevow-0.4.1 )
	>=dev-python/imaging-1.1"

src_install() {
	local inspath

	python_version
	inspath=$(python_get_sitedir)/${PN}
	insinto ${inspath}
	doins -r data src tools
	newins PyICQt.py ${PN}.py

	insinto /etc/jabber
	newins config_example.xml ${PN}.xml
	fperms 600 /etc/jabber/${PN}.xml
	fowners jabber:jabber /etc/jabber/${PN}.xml
	dosed \
		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
		/etc/jabber/${PN}.xml
	dosed \
		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
		/etc/jabber/${PN}.xml

	newinitd "${FILESDIR}/${PN}-0.8-initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/${PN}

	elog "A sample configuration file has been installed in /etc/jabber/${PN}.xml."
	elog "Please edit it and the configuration of your Jabber server to match."
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
