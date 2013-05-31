# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python module for retrieving WHOIS information of domains"
HOMEPAGE="http://code.google.com/p/pywhois/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${PF}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
IUSE=""
