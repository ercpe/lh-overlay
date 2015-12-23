# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Generic portlets for Django"
HOMEPAGE="http://code.google.com/p/django-portlets/"
SRC_URI="https://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">dev-python/django-1.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}"
