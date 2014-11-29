# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Django Form wrapper for Twitter-Bootstrap"
HOMEPAGE="https://pypi.python.org/pypi/django-crispy-forms http://django-crispy-forms.readthedocs.org/en/d-0/"
SRC_URI="mirror://pypi/d/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">dev-python/django-1.2[${PYTHON_USEDEP}]"
DEPEND=""
