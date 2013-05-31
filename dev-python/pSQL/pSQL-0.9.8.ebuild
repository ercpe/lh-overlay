# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="MySQL abstraction layer for python"
HOMEPAGE="http://software.fionet.com/pSQL/"
SRC_URI="http://software.fionet.com/pSQL/release/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-python/mysql-python"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/01-datetime.patch"
}

src_install() {
	dodir $(python_get_sitedir)/pSQL || die "dodir failed"
	insinto $(python_get_sitedir)/pSQL

	doins pSQL.py
	touch "${D}"/$(python_get_sitedir)/pSQL/__init__.py
}