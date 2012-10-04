# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A CLI curses based monitoring tool for GNU/Linux and BSD OS."
HOMEPAGE="https://github.com/nicolargo/glances"
SRC_URI="https://github.com/downloads/nicolargo/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL"
IUSE=""

RDEPEND=">=dev-python/psutil-0.4.1 dev-python/jinja"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${P}

PYTHON_MODNAME=glances
