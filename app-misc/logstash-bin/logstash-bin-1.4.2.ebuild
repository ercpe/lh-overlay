# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils user

MY_PN="${PN%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Event and log manager"
HOMEPAGE="http://logstash.net/"
SRC_URI="https://download.elasticsearch.org/${MY_PN}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="strip"

RDEPEND="virtual/jre:1.7"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup ${MY_PN}
	enewuser ${MY_PN} -1 /bin/bash /var/lib/${MY_PN} ${MY_PN}
}

src_install() {
	insinto /usr/share/${MY_PN}
	doins -r ./*
	chmod +x "${D}"/usr/share/${MY_PN}/bin/* || die

	keepdir /etc/${MY_PN}
	keepdir /var/lib/${MY_PN}
	mkdir -p "${D}"/var/lib/${MY_PN}/elasticsearch/{config,data,work,plugins} || die
	fowners ${MY_PN}:${MY_PN} /var/lib/${MY_PN} -R
	fperms 0750 /var/lib/${MY_PN} -R

	newinitd "${FILESDIR}/${MY_PN}.initd" "${MY_PN}"
	newconfd "${FILESDIR}/${MY_PN}.confd" "${MY_PN}"
}
