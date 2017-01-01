# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils vcs-snapshot

GIT_COMMIT="8c84e5eb534266db866e012db20637526ad96555"

DESCRIPTION="Apache2 module for writing access logs to Graylog"
HOMEPAGE="https://github.com/Graylog2/apache-mod_log_gelf"
SRC_URI="https://github.com/Graylog2/apache-mod_log_gelf/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=www-servers/apache-2.4
		dev-libs/json-c
		sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_prepare() {
	default
	epatch "${FILESDIR}"/Makefile.patch
}

src_install() {
	default
	insinto /etc/apache2/modules.d/
	newins "${FILESDIR}/apache.include" "50_mod_log_gelf.conf"
}
