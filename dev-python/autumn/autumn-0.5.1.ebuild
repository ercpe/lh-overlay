# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.1"

inherit distutils

DESCRIPTION="A super-lightweight Object-relational mapper (ORM) for Python"
HOMEPAGE="http://autumn-orm.org/"
SRC_URI="mirror://pypi/a/autumn/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="MIT"
IUSE=""
