# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python framework for building munin plugins"
HOMEPAGE="http://samuelks.com/python-munin/"
SRC_URI="https://github.com/samuel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# the memcached plugin in the release is broken
	sed -i -e 's/values =/values = {}/g' "${S}"/munin/memcached.py || die
}
