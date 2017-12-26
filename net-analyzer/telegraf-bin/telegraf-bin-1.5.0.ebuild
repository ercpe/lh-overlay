# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit systemd user

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The plugin-driven server agent for collecting & reporting metrics - Bin Package"
HOMEPAGE="
	https://github.com/influxdata/telegraf
	https://www.influxdata.com/time-series-platform/telegraf/"
SRC_URI="https://dl.influxdata.com/${MY_PN}/releases/${MY_P}_linux_amd64.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S="${WORKDIR}/${MY_PN}"

QA_PREBUILT="/opt/bin/*"

pkg_setup() {
	enewuser ${MY_PN}
}

src_install() {
	dodir /etc/${MY_PN}/${MY_PN}.d
	dodir /var/log/${MY_PN}
	fowners ${MY_PN} /var/log/${MY_PN}
	if [[ ! -e /etc/${MY_PN}.conf ]]; then
		"${WORKDIR}/${MY_PN}/usr/bin/${MY_PN}" config > "${D}"/etc/${MY_PN}/${MY_PN}.conf || die
	fi

	systemd_dounit usr/lib/telegraf/scripts/telegraf.service
	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}
	newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}

	into /opt
	dobin usr/bin/${MY_PN}
	dosym ../../opt/bin/${MY_PN} /usr/bin/${MY_PN}
}
