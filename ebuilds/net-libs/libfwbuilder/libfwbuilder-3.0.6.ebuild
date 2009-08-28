# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4

DESCRIPTION="Firewall Builder 3.0 API library and compiler framework"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="bind snmp stlport"

DEPEND="
	>=dev-libs/libxml2-2.4.10
	>=dev-libs/libxslt-1.0.7
	x11-libs/qt-core
	snmp? ( net-analyzer/net-snmp )
	stlport? ( dev-libs/STLport )
	bind? ( net-dns/bind )"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4_src_prepare

	sed -i \
		-e '/COPYING/d' -e '/INSTALL/d' \
		doc/doc.pro || die "sed failed"

	sed -i \
		-e '/\.\/runqmake\.sh$/d' \
		configure || die "sed configure failed"
}

src_configure() {
	use snmp || export with_ucdsnmp="no"
	econf \
		--with-docdir="/usr/share/doc/${PF}" \
		$(use_with stlport stlport) \
		$(use_with bind lwres)

	for pro_file in $(find "${S}" -name "*.pro"); do
		eqmake4 "${pro_file}" -o "$(dirname ${pro_file})/Makefile" "CONFIG+=nostrip" || die "running eqmake4 for ${pro_file} failed"
	done
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}
