# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

SUPPORT_PYTHON_ABIS="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils python vcs-snapshot

DESCRIPTION="A utility for Django that implements the Django Storage API and stores the contents of the files in your Django database instead of on the filesystem."
HOMEPAGE="https://github.com/mmueller/django-database-storage"
SRC_URI="https://github.com/mmueller/django-database-storage/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="database_storage"
