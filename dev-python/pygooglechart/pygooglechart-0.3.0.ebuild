# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Complete Python wrapper for the Google Chart API"
HOMEPAGE="http://pygooglechart.slowchop.com/ https://pypi.python.org/pypi/pygooglechart/"
SRC_URI="http://pygooglechart.slowchop.com/files/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""
