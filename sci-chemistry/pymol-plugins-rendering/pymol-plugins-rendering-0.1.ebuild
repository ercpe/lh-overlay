# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python toolchain-funcs

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
DESCRIPTION="ProMOL is capable of accurately recognizing catalytic sites nearly every time."
SRC_URI="http://ase-web.rit.edu/~ez-viz/ProMOL.zip"
HOMEPAGE="http://ase-web.rit.edu/~ez-viz/index.html"
IUSE=""
RESTRICT="mirror"
RDEPEND=">sci-chemistry/pymol-0.99"
DEPEND=""

src_unpack(){
	python_version
	unpack ProMOL.zip
	sed -e "s:./modules:/usr/$(get_libdir)/python${PYVER}/site-packages:g" -i ProMOL_302.py
}
src_install(){
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
	doins ProMOL_302.py
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/pmg_tk/startup/
}