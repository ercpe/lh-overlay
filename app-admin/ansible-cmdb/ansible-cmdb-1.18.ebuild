# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Generate host overview from ansible fact gathering output"
HOMEPAGE="https://github.com/fboender/ansible-cmdb"
SRC_URI="https://github.com/fboender/ansible-cmdb/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/mako[${PYTHON_USEDEP}]
		dev-python/ushlex[${PYTHON_USEDEP}]
		dev-python/jsonxs[${PYTHON_USEDEP}]"

src_prepare() {
	default
	rm -r mako yaml Makefile || die
}

install_module() {
	python_moduleinto ${PN/-/}
	python_domodule "${S}"/${PN/-/}/*
}

src_install() {
	python_foreach_impl install_module
	dobin ${PN}
	doman ${PN}.man.1
}
