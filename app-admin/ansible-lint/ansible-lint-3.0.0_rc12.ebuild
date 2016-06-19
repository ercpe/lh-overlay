# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_P=${P/_/}

DESCRIPTION="Checks ansible playbooks for practices and behaviour that can be improved"
HOMEPAGE="https://github.com/willthames/ansible-lint"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]"
