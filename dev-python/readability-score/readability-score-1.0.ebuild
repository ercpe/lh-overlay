# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Python library to calculate the readability score of a text"
HOMEPAGE="https://github.com/wimmuskee/readability-score"
SRC_URI="https://github.com/wimmuskee/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/nltk[${PYTHON_USEDEP}]
		dev-python/hyphenator[${PYTHON_USEDEP}]"

pkg_postinst() {
	einfo "To support multiple locales, you have to install the matching myspell-* package"
}
