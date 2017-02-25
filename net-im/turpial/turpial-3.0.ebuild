# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="Turpial"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A light, beautiful and functional microblogging client"
HOMEPAGE="http://turpial.org.ve/"
SRC_URI="https://github.com/satanas/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="phonon qt4"

RDEPEND="
	net-libs/lib${PN}[${PYTHON_USEDEP}]
	net-libs/webkit-gtk:3[introspection]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/gst-python:1.0=[${PYTHON_USEDEP}]
	dev-python/Babel[${PYTHON_USEDEP}]
	qt4? ( dev-python/PyQt4[${PYTHON_USEDEP},webkit,phonon?] )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}
