# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 ) # ,3_2,3_3,3_4 due to dependency to oauth-plus

inherit distutils-r1

DESCRIPTION="A powerful and flexible toolkit that makes it easy to build Web APIs using Django"
HOMEPAGE="http://django-rest-framework.org/"
SRC_URI="https://github.com/tomchristie/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="browsable-api oauth xml yaml"

DEPEND=">=dev-python/django-1.4.2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	browsable-api? (
		>=dev-python/markdown-2.1.0[${PYTHON_USEDEP}]
	)
	oauth? (
		>=dev-python/django-oauth-plus-2.0[${PYTHON_USEDEP}]
		>=dev-python/oauth2-1.5.211[${PYTHON_USEDEP}]
	)
	xml? ( dev-python/defusedxml[${PYTHON_USEDEP}] )
	yaml? ( >=dev-python/pyyaml-3.10[${PYTHON_USEDEP}] )
"

python_test() {
	DISTUTILS_NO_PARALLEL_BUILD=1 ${EPYTHON} rest_framework/runtests/runtests.py || die
}
