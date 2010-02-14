# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python

DESCRIPTION="PySVN Workbench GUI"
HOMEPAGE="http://pysvn.tigris.org/"
SRC_URI="http://pysvn.barrys-emacs.org/source_kits/WorkBench-${PV}.tar.gz"

LICENSE="Apache-1.1"

SLOT="0"
KEYWORDS="~x86 amd64"

IUSE=""
DEPEND=">=dev-lang/python-2.4 dev-python/pysvn >=dev-python/wxpython-2.6.10"
RDEPEND="${DEPEND}"

S="${WORKDIR}/WorkBench-${PV}"


src_install() {
	insinto $(python_get_sitedir)/${PN}
	doins -r ${S}/Source/*
	
	cat >> "${T}"/pysvn-workbench <<- EOF
#!/bin/bash
python -O $(python_get_sitedir)/${PN}/wb_main.py
EOF
	dobin "${T}"/pysvn-workbench
}
