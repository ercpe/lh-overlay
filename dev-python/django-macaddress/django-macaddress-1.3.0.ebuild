# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="MAC address model and form fields for Django apps"
HOMEPAGE="https://github.com/tubaman/django-macaddress"
SRC_URI="https://github.com/tubaman/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/netaddr[${PYTHON_USEDEP}]
		dev-python/django[${PYTHON_USEDEP}]"