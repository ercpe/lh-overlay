# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="QR Code generator for django-otp"
HOMEPAGE="https://repos.j-schmitz.net/gitweb/?p=django-otp-qr.git;a=summary"
SRC_URI="https://repos.j-schmitz.net/gitweb/?p=django-otp-qr.git;a=snapshot;h=d58593a09650745cb7a65f09ca6411cb55155834;sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
		dev-python/qrcode[${PYTHON_USEDEP}]"
