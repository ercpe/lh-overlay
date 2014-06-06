# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} )

inherit python-r1 vcs-snapshot

DESCRIPTION="Nagios check to test for Gentoo package updates"
HOMEPAGE="http://repos.j-schmitz.net/gitweb/?p=nagios-check_updates.git;a=summary"
SRC_URI="http://repos.j-schmitz.net/gitweb/?p=nagios-check_updates.git;a=snapshot;h=864e73318ac5eb8c93bfc9fa9a5c735e34631b87;sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-portage/gentoolkit[${PYTHON_USEDEP}]"

#S="${WORKDIR}"

src_install() {
	python_foreach_impl python_newscript "src/${PN/nagios-}.py" ${PN/nagios-}
}
