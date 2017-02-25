# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="An experimental indexing and search engine for e-mail"
HOMEPAGE="https://www.mailpile.is/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mailpile/Mailpile.git"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-python/jinja:0[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/pgpdump[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pydns:2[${PYTHON_USEDEP}]
	mail-filter/spambayes[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

python_prepare_all() {
	rm -rvf test* || die
	distutils-r1_python_prepare_all
}
