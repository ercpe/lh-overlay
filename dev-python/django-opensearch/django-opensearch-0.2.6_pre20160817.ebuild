# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 vcs-snapshot

GIT_COMMIT=fcc7115dd9f50e3c0180f69cc1d95738c9a3db9a

DESCRIPTION="A django reusable application to handle opensearch.xml"
HOMEPAGE="https://github.com/vint21h/django-opensearch"
SRC_URI="https://github.com/ercpe/${PN}/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/django-1.7[${PYTHON_USEDEP}]"
