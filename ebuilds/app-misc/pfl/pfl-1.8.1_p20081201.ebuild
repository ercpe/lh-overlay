# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="PFL is an online searchable file/package database for Gentoo"
SRC_URI="http://files.portagefilelist.de/${PN}-1.8.1
	 http://files.portagefilelist.de/e-file-20081201"
HOMEPAGE="http://www.portagefilelist.de/index.php/Special:PFLQuery"
IUSE=""
RESTRICT="mirror"

DEPEND=""


src_unpack(){
	cp "${DISTDIR}"/${PN}-1.8.1 "${WORKDIR}"/${PN}.py
	cp "${DISTDIR}"/e-file-20081201 "${WORKDIR}"/e-file
}

src_install(){
	python_version
	cat >> "${T}/${PN}" <<- EOF
	#!/bin/sh

	exec nice ${python} -O /usr/$(get_libdir)/pfl/${PN}.py

	EOF

	exeinto "/etc/cron.daily/"
	doexe "${T}/${PN}"

	exeinto "/usr/$(get_libdir)/${PN}/"
	doexe "${PN}.py"

	dobin "e-file"

}
