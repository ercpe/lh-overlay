# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A library that can be used to add OpenID support to Django applications."
HOMEPAGE="https://launchpad.net/django-openid-auth"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-python/django dev-python/python-openid"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}

PYTHON_MODNAME=django_openid_auth
