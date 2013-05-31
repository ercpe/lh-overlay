# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A set of useful django extensions"
HOMEPAGE="http://www.j-schmitz.net/projects/django-extras/"
SRC_URI="http://www.j-schmitz.net/releases/django-extras/${P}.tar.bz2"

RESTRICT="mirror"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">dev-python/django-1.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}

PYTHON_MODNAME=djangoextras
