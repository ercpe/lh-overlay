# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils python-r1

DESCRIPTION="MySQL abstraction layer for python"
HOMEPAGE="http://software.fionet.com/pSQL/"
SRC_URI="http://software.fionet.com/pSQL/release/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/mysql-python[${PYTHON_USEDEP}]
	dev-python/egenix-mx-base[${PYTHON_USEDEP}]"
DEPEND=""

src_install() {
	python_parallel_foreach_impl python_domodule pSQL.py

	dodoc *pSQL
}
