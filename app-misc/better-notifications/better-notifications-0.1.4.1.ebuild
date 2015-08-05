# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Better notifications for Nagios/Icinga"
HOMEPAGE="https://ercpe.de/projects/better-notifications"
SRC_URI="https://github.com/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/jinja:0[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install

	insinto /etc/better-notifications
	newins "${S}"/doc/backends_sample.cfg backends.cfg
	doins -r "${S}"/doc/templates

	python_foreach_impl python_newscript "${S}"/src/${PN/-/}/better-notify.py better-notify
}
