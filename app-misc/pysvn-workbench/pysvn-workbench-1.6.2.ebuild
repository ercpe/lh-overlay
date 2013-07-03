# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils python-single-r1

DESCRIPTION="PySVN Workbench GUI"
HOMEPAGE="http://pysvn.tigris.org/"
SRC_URI="http://pysvn.barrys-emacs.org/source_kits/WorkBench-${PV}.tar.gz"

SLOT="0"
LICENSE="Apache-1.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/WorkBench-${PV}"

src_install() {
	insinto $(python_get_sitedir)/${PN}
	doins -r "${S}"/Source/*

	cat >> "${T}"/pysvn-workbench <<- EOF
	#!/bin/bash
	${EPYTHON} -O $(python_get_sitedir)/${PN}/wb_main.py
	EOF
	dobin "${T}"/pysvn-workbench
}
