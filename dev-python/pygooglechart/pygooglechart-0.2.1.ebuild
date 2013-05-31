# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.1"

inherit distutils

DESCRIPTION="Complete Python wrapper for the Google Chart API"
HOMEPAGE="http://pygooglechart.slowchop.com/"
SRC_URI="http://pygooglechart.slowchop.com/files/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""

PYTHON_MODNAME=${PN}.py
