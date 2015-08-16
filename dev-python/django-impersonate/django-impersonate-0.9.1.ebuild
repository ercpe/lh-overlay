# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Simple application to allow superusers to impersonate other non-superuser accounts."
HOMEPAGE="https://bitbucket.org/petersanchez/django-impersonate"
SRC_URI="https://bitbucket.org/petersanchez/django-impersonate/get/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/django[${PYTHON_USEDEP}]"
