# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Django app for storing files in the database instead of on the filesystem"
HOMEPAGE="https://github.com/mmueller/django-database-storage"
SRC_URI="https://github.com/mmueller/django-database-storage/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND=""
