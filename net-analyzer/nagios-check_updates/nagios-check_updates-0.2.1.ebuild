# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

inherit python-r1

DESCRIPTION="Nagios check to test for Gentoo package updates"
HOMEPAGE="https://ercpe.de/projects/nagios-check_updates"
SRC_URI="https://git.ercpe.de/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-portage/gentoolkit[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}"

src_install() {
	python_foreach_impl python_newscript "src/${PN/nagios-}.py" ${PN/nagios-}
}
