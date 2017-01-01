# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python framework for building munin plugins"
HOMEPAGE="http://samuelks.com/python-munin/"
SRC_URI="https://github.com/samuel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plugins"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# the memcached plugin in the release is broken
	sed -i -e 's/values =/values = {}/g' "${S}"/munin/memcached.py || die
}

python_install_all() {
	distutils-r1_python_install_all

	if use plugins; then
		python_scriptinto /usr/libexec/munin/plugins
		python_foreach_impl python_doscript plugins/*
	fi
}
