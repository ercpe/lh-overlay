# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Linux Filesystem Permissions Watcher"
HOMEPAGE="https://ercpe.de/projects/permwatcher"
SRC_URI="https://code.not-your-server.de/permwatcher.git/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyinotify[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install

	insinto /etc/
	newins "${S}"/doc/example.cfg permwatcher.cfg

	python_foreach_impl python_newscript "${S}"/src/${PN}/main.py ${PN}

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
