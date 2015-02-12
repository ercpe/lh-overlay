# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-r1 vcs-snapshot

DESCRIPTION="Nagios check to test for changes in DNS records"
HOMEPAGE="https://ercpe.de/projects/${PN}"
SRC_URI="https://code.not-your-server.de/${PN}.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]"

src_prepare() {
	sed -i '1 i\#!/usr/bin/env python2.7' "${PN/nagios-}.py" || die
}

src_install() {
	python_foreach_impl python_newscript "${PN/nagios-}.py" ${PN/nagios-}
}
