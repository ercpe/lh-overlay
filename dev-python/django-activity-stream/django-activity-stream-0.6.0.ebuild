# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Creating activities from the actions on your site following the Activity Streams specification"
HOMEPAGE="https://github.com/justquick/django-activity-stream https://pypi.python.org/pypi/django-activity-stream"
SRC_URI="mirror://pypi/d/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND=""

S="${WORKDIR}/${MY_P}"
