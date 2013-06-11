# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A set of useful django extensions"
HOMEPAGE="http://www.j-schmitz.net/projects/django-extras/"
SRC_URI="http://www.j-schmitz.net/releases/django-extras/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">dev-python/django-1.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/
