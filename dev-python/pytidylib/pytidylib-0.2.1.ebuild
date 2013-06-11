# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python wrapper for HTML Tidy (tidylib)"
HOMEPAGE="http://countergram.com/open-source/pytidylib"
SRC_URI="http://cloud.github.com/downloads/countergram/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-text/htmltidy"
