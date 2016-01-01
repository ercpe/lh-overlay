# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4} )

inherit python-r1

DESCRIPTION="Nagios check to test for Gentoo package updates"
HOMEPAGE="https://ercpe.de/projects/nagios-check_updates"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-portage/gentoolkit[${PYTHON_USEDEP}]"

src_install() {
	python_foreach_impl python_newscript "src/${PN/nagios-}.py" ${PN/nagios-}
}
