# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_3 )

inherit distutils-r1

DESCRIPTION="TTool to ease the creation of gentoo-based XEN DomUs"
HOMEPAGE="https://github.com/ercpe/gentoo-bootstrap"
SRC_URI="https://github.com/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/cfgio[${PYTHON_USEDEP}]
		dev-python/sh[${PYTHON_USEDEP}]
		sys-fs/lvm2
		app-emulation/xen-tools"

src_install() {
	distutils-r1_src_install

	insinto /etc/gentoo-bootstrap
	doins doc/configs/storage-simple.cfg
	doins doc/configs/sample.cfg

	exeinto /usr/share/gentoo-bootstrap
	doexe tools/chroot-bootstrap.sh

	python_scriptroot=/usr/sbin python_foreach_impl python_newscript ${S}/src/${PN/-/}/main.py gentoo-bootstrap
}
