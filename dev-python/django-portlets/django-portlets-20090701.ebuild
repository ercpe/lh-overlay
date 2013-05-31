# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Generic portlets for Django"
HOMEPAGE="http://code.google.com/p/django-portlets/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="BSD"
IUSE=""

RDEPEND=">dev-python/django-1.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}

PYTHON_MODNAME=portlets
