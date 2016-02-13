# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Bulk update using one query over Django ORM"
HOMEPAGE="https://github.com/aykut/django-bulk-update"
SRC_URI="https://github.com/aykut/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

src_prepare() {
	rm -r "${S}/tests" || die
}