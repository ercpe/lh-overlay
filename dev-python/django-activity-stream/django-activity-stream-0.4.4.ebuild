# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Creating activities from the actions on your site following the Activity Streams specification"
HOMEPAGE="https://github.com/justquick/django-activity-stream http://justquick.github.com/django-activity-stream/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
DEPEND=""

S="${WORKDIR}"
