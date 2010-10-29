# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"

inherit autotools python

DESCRIPTION="Storage Device Manager"
HOMEPAGE="http://pysdm.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	echo "true" > py-compile
	sed "s:constants.data_dir:\"${EPREFIX}/usr/share/${PN}\":g" -i pysdm/pysdm.py || die
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		pysdmdir="$(python_get_sitedir)/${PN}" \
		install || die

	cat > "${ED}"/usr/bin/${PN} <<- EOF
	#!/bin/bash
	$(PYTHON) -O $(python_get_sitedir)/${PN}/${PN}.py
	EOF
}

pkg_postinst() {
	python_mod_optimize ${PN}
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
