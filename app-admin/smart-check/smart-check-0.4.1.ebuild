# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy )

inherit distutils-r1

DESCRIPTION="A smart S.M.A.R.T. check"
HOMEPAGE="https://ercpe.de/projects/smart-check"
SRC_URI="https://git.ercpe.de/ercpe/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
		sys-apps/smartmontools"

S="${WORKDIR}/${PN}"

src_install() {
	distutils-r1_src_install

	python_foreach_impl python_newscript "${S}"/${PN/-/}/__main__.py "${PN}"
}
