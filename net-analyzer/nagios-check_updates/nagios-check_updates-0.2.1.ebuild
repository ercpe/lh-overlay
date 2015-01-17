# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} )

inherit python-r1 vcs-snapshot

DESCRIPTION="Nagios check to test for Gentoo package updates"
HOMEPAGE="https://ercpe.de/projects/nagios-check_updates"
SRC_URI="https://repos.j-schmitz.net/gitweb/?p=nagios-check_updates.git;a=snapshot;h=1e952e3ffb90338569ffd1286633260a1a1d9431;sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-portage/gentoolkit[${PYTHON_USEDEP}]"

src_install() {
	python_foreach_impl python_newscript "src/${PN/nagios-}.py" ${PN/nagios-}
}
