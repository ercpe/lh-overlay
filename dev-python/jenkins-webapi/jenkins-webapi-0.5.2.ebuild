# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy )

inherit distutils-r1

JENKINS_VERSION="1.596.3"

DESCRIPTION="Module for interacting with the Jenkins CI server"
HOMEPAGE="https://github.com/gvalkov/jenkins-webapi"
SRC_URI="https://github.com/gvalkov/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/requests-2.7.0[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		>=dev-python/sphinx-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/alabaster-0.6.1[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
