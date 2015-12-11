# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Storage Device Manager"
HOMEPAGE="http://pysdm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

src_prepare() {
	sed "s:constants.data_dir:\"${EPREFIX}/usr/share/${PN}\":g" -i pysdm/pysdm.py || die
}

src_install() {
	emake \
		DESTDIR="${ED}" \
		pysdmdir="$(python_get_sitedir)/${PN}" \
		install

	cat > "${ED}"/usr/bin/${PN} <<- EOF
	#!/bin/bash
	${PYTHON} -O $(python_get_sitedir)/${PN}/${PN}.py
	EOF
}
