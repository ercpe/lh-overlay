# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS=""

inherit distutils

DESCRIPTION="A small ORM for python"
HOMEPAGE="http://charlesleifer.com/blog/peewee-a-lightweight-python-orm/"
SRC_URI="http://gentoo.j-schmitz.net/portage-overlay/${CATEGORY}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~x86"
LICENSE="as-is"
IUSE=""

PYTHON_MODNAME=${PN}.py
