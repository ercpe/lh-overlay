# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="PFL is an online searchable file/package database for Gentoo"
SRC_URI="http://files.portagefilelist.de/${PN}
	 http://files.portagefilelist.de/e-file"
HOMEPAGE="http://www.portagefilelist.de/index.php/Special:PFLQuery"
IUSE=""
RESTRICT="mirror"

DEPEND=""


src_unpack(){
	cp "${DISTDIR}"/${PN} "${WORKDIR}"/${PN}.py
	cp "${DISTDIR}"/e-file "${WORKDIR}"/e-file
}

src_install(){
	python_version
	cat >> "${T}/${PN}" <<- EOF
	#!/bin/sh

	exec nice ${python} -O /usr/lib/pfl/${PN}.py

	EOF

	exeinto /etc/cron.daily/
	doexe "${T}/${PN}"

	exeinto /usr/lib/${PN}/
	doexe ${PN}.py

	dobin e-file
}
