# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_3 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Linux Filesystem Permissions Watcher"
HOMEPAGE="https://repos.j-schmitz.net/gitweb/?p=permwatcher.git;a=summary"
SRC_URI="https://repos.j-schmitz.net/gitweb/?p=permwatcher.git;a=snapshot;h=c8d1997e720ea88fe7e11c412c78a14296869869;sf=tgz -> ${P}.tar.gz"
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
