# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="QR Code generator for django-otp"
HOMEPAGE="https://code.not-your-server.de/django-otp-qr.git"
SRC_URI="https://code.not-your-server.de/django-otp-qr.git/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
		dev-python/qrcode[${PYTHON_USEDEP}]"

S="${WORKDIR}"
