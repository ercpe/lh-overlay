# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} )

inherit python-r1 vcs-snapshot

DESCRIPTION="Nagios check to test for Gentoo package updates"
HOMEPAGE="http://repos.j-schmitz.net/gitweb/?p=nagios-check_updates.git;a=summary"
SRC_URI="http://repos.j-schmitz.net/gitweb/?p=nagios-check_updates.git;a=snapshot;h=b6e583983b43ee2a6c76bca0b79e139006098c1d;sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="app-portage/gentoolkit[${PYTHON_USEDEP}]"

src_install() {
	python_foreach_impl python_newscript "src/${PN/nagios-}.py" ${PN/nagios-}
}
