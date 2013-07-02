# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="OpenID support to Django applications"
HOMEPAGE="https://launchpad.net/django-openid-auth"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/python-openid[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}
