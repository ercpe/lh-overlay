# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Python framework for building munin plugins"
HOMEPAGE="http://samuelks.com/python-munin/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/samuel/python-munin.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="plugins"

python_install_all() {
	distutils-r1_python_install_all

	if use plugins; then
		python_scriptinto /usr/libexec/munin/plugins
		python_foreach_impl python_doscript plugins/*
	fi
}
