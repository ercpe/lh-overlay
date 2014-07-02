# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Web toolset for administrating servers"
HOMEPAGE="http://ajenti.org/"
SRC_URI="https://github.com/Eugeny/ajenti/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="ldap"

RDEPEND="
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/gevent-socketio
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/python-catcher
	dev-python/python-daemon[${PYTHON_USEDEP}]
	dev-python/python-exconsole
	dev-python/passlib
	dev-python/psutil
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/reconfigure
	dev-python/requests
	ldap? ( dev-python/python-ldap )"
DEPEND="${RDEPEND}"

python_compile_all() {
	"${PYTHON}" ./compile_resources.py || die
}

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}"/${PN}.init ${PN}
}
