# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="MySQL User Defined Functions for the ssdeep API "
HOMEPAGE="https://github.com/treffynnon/lib_mysqludf_ssdeep"
SRC_URI="https://github.com/treffynnon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/mysql-5.1
			app-crypt/ssdeep"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

pkg_setup() {
	MYSQL_PLUGINDIR="$(mysql_config --plugindir)"
}

src_prepare() {
	default
	eautoreconf
}

src_install() {
	exeinto "${MYSQL_PLUGINDIR}"
	doexe .libs/${PN}.so

	dodoc *.sql ../README.markdown
}

pkg_postinst() {
	einfo "After installation, you have to execute the commands in /usr/share/doc/${P}/installdb.sql.bz2 in order to use the UDF."
}