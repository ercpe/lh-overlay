# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python wrapper for HTML Tidy (tidylib)"
HOMEPAGE="http://countergram.com/open-source/pytidylib"
SRC_URI="http://cloud.github.com/downloads/countergram/${PN}/${P}.tar.gz"

DEPENDS="app-text/htmltidy"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
IUSE=""
