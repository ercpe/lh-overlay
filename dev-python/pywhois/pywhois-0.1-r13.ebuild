# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Retrieve WHOIS information of domains"
HOMEPAGE="http://code.google.com/p/pywhois/"
SRC_URI="https://gentoo.j-schmitz.net/overlays/last-hope/${PF}.tar.bz2"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
IUSE=""
