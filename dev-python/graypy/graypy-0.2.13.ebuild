# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Python logging handler for Graylog2 that sends messages in GELF."
HOMEPAGE="https://github.com/severb/graypy"
SRC_URI="https://github.com/severb/graypy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amqp"

RDEPENDS="amqp? ( dev-python/amqplib[${PYTHON_USEDEP}] )"
