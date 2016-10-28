# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Tool to ease the creation of gentoo-based XEN DomUs"
HOMEPAGE="https://ercpe.de/projects/gentoo-bootstrap https://github.com/ercpe/gentoo-bootstrap"
SRC_URI="https://github.com/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-python/cfgio[${PYTHON_USEDEP}]
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

	python_scriptroot=/usr/sbin python_foreach_impl python_newscript "${S}"/src/${PN/-/}/main.py gentoo-bootstrap
}
