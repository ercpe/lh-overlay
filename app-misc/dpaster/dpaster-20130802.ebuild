# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Quick & dirty client interface to to the http://dpaste.com/ pastebin"
HOMEPAGE="https://github.com/zodman/dpaster"
SRC_URI="http://gentoo.j-schmitz.net/overlays/last-hope/${P}.tar.bz2"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/twill[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
