# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

PYTHON_MODNAME="model_utils"

DESCRIPTION="Django model mixins and utilities."
HOMEPAGE="https://github.com/carljm/django-model-utils"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="as-is"
IUSE=""

RDEPEND=">dev-python/django-1.2"
DEPEND=""
